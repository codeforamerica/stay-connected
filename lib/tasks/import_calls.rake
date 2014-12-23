require File.expand_path('../../twilio_importer', __FILE__)

desc 'Imports all calls from Twilio - used by heroku scheduler daily'
task :import_calls => :environment do
  TwilioImporter.new.load_calls!
end