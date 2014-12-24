class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception
  before_filter :generate_metrics

  def generate_metrics
    client = Twilio::REST::Client.new(ENV['TWILIO_SID'], ENV['TWILIO_AUTH'])
    numbers = client.account.incoming_phone_numbers.list.map { |n| n.phone_number }
    all_calls = Call.all

    @human_connected_calls = all_calls.where.not(parent_call_sid: '')

    @holding_calls = @human_connected_calls.map { |c| Call.find_by_sid(c.parent_call_sid)}.compact
    @total_hold_duration = @holding_calls.inject(0) { |sum, c| sum + c.duration } / 60 / 60 #from seconds to hours

    @initiated_calls = all_calls.select { |c| numbers.include? c.to_number }

    @unique_incoming_phone_numbers_count = @initiated_calls.map { |c| c.from_number}.uniq.count

    @human_connection_rate = @human_connected_calls.count / @initiated_calls.count.to_f
  end

  def index
  end

  # For ducksboard
  def people
    render :json => {'value' => @unique_incoming_phone_numbers_count}
  end

  # For ducksboard
  def hours
    render :json => {'value' => @total_hold_duration}
  end

  # For ducksboard
  def successes
    render :json => {'value' => @human_connected_calls.count}
  end

  # For ducksboard
  def rate
    render :json => {'value' => @human_connection_rate}
  end
end
