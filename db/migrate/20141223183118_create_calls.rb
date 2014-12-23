class CreateCalls < ActiveRecord::Migration
  def change
    create_table :calls do |t|
      t.string :sid
      t.string :to_number
      t.string :from_number
      t.string :direction
      t.integer :duration
      t.string :parent_call_sid
      t.datetime :date
      t.timestamps
    end
  end
end