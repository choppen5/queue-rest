require 'rubygems'
require 'sinatra'
require 'twilio-ruby'


############ CONFIG ###########################
# Find these values at twilio.com/user/account
account_sid = ENV['twilio_account_sid']
auth_token =  ENV['twilio_account_token']
app_id =  ENV['twilio_app_id']


@client = Twilio::REST::Client.new(account_sid, auth_token)



#for incoming voice calls send to queue
post '/voice' do

    response = Twilio::TwiML::Response.new do |r|  

            r.Say("Welcome to CoHealthOps")
            r.Enqueue("WelcomeQueue")
     end
   
    puts "response text = #{response.text}"
    response.text
end




