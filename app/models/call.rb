class Call < ActiveRecord::Base
  attr_accessible :sid, :to_number, :from_number, :direction, :duration, :parent_call_sid, :date
end
