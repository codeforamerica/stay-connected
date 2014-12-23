class TwilioImporter
  def load_calls!
    puts "Importing twilio calls..."
    client = Twilio::REST::Client.new(ENV['TWILIO_SID'], ENV['TWILIO_AUTH'])
    calls = client.account.calls.list
    total = calls.total
    count = 0
    while calls do
      puts "Begin processing calls"
      calls.each do |c|
        if Call.find_by_sid(c.sid) == nil
          Call.create(
            sid: c.sid,
            to_number: c.to,
            from_number: c.from,
            direction: c.direction,
            duration: c.duration,
            parent_call_sid: c.parent_call_sid ? c.parent_call_sid : '',
            date: c.date_created
          )
        end
        count += 1
        puts "Processed call #{count} of #{total}: #{c.sid}"
      end
      calls = calls.try(:next_page) # will be [] for last page
    end
  end
end
