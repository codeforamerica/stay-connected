# Connect Metrics

This is a little app to track metrics for [Connect](https://github.com/codeforamerica/connect). It uses Rails + Postgres and pulls call data from Twilio.

It's deployed on heroku: http://stay-connected-metrics.herokuapp.com/people

And powers this Ducksboard: https://public.ducksboard.com/NsoSQbe655DQ0DlvQxr6/

Check out the [Connect project repo](https://github.com/codeforamerica/connect) for details on the project

# Local setup
1) Pull the code

2) Create .env file with these env vars:
- TWILIO_SID
- TWILIO_AUTH

3) Setup your Postgres DB
- `rake db:create`
- `rake db:migrate`

4) Load data from Twilio
- `foreman run import_calls`

5) Check it!
- `foreman run rails s`
- Open a browser and go to `localhost:3000`