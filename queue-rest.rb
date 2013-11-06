require 'rubygems'
require 'sinatra'
require 'twilio-ruby'


############ CONFIG ###########################
# Find these values at twilio.com/user/account
account_sid = ENV['twilio_account_sid']
auth_token =  ENV['twilio_account_token']
app_id =  ENV['twilio_app_id']

caller_id = '+14423336837'

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

#http
get '/connect-to-agent' do

  #pass in agent targets number
  agent_num = params['agent_num']

  #rest call to start a call, gahter response URL = 'get-response'
  @client = Twilio::REST::Client.new(account_sid, auth_token)

  @client.account.calls.create(:from => caller_id, :to => agent_num, :url => URI.escape("https://macbook.ngrok.com/confirm-agent-reservation"))
   
end

post '/confirm-agent-reservation' do

  #1. Do a gather  - Action will be = dequeue-connection
    response = Twilio::TwiML::Response.new do |r|

    # call screen
    r.Pause "1"
    r.Gather(:action => URI.escape("/dequeue-connection"), :timeout => "10", :numDigits => "1") do |g|
      g.Say("You have a customer ready, press 1 to talk to them")
    end

    # no key was pressed
    r.hangup

    return r.text

  end


end

post '/dequeue-connection' do
  puts params

  #rest dequeue front of queue.. 
  return "<Response><Dial><Queue>WelcomeQueue</Queue></Dial></Response>"

 

end 






