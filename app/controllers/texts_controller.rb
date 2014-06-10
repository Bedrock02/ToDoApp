# {
#   "AccountSid"=>"<string>", 
#   "Body"=>"the message content", 
#   "ToZip"=>"<string>", 
#   "FromState"=>"<string>", 
#   "ToCity"=>"<string>", 
#   "SmsSid"=>"<string>", 
#   "ToState"=>"<string>", 
#   "To"=>"<string>", 
#   "ToCountry"=>"<string>", 
#   "FromCountry"=>"<string>", 
#   "SmsMessageSid"=>"<string>", 
#   "ApiVersion"=>"<string>", 
#   "FromCity"=>"<string>", 
#   "SmsStatus"=>"<string>", 
#   "From"=>"<string>", 
#   "FromZip"=>"<string>"
# }

class TextsController < ApplicationController
	include Webhookable
	
	def index
	end

	def text_test
		account_sid = "AC3126b43bc8d57aa5750bc123c75aabab"
		auth_token = "ab465cea4dd39ee5bd577eab69adce53"
		@client = Twilio::REST::Client.new account_sid, auth_token


		@client.account.messages.create(
			:from => "+13473345437",
			:to => "+16467031728",
			:body => params[:q]
			)

		redirect_to action: :index
	end

	def text_response
		@twiml = Twilio::TwiML::Response.new do |r|
			r.Message "Thank you for texting in"
		end
	end

	def messaging
		
		message_body = params["Body"]
		from_number = params["From"]
		from_zip = params["FromZip"]

		account_sid = "AC3126b43bc8d57aa5750bc123c75aabab"
		auth_token = "ab465cea4dd39ee5bd577eab69adce53"
		@client = Twilio::REST::Client.new account_sid, auth_token


		@client.account.messages.create(
			:from => "+13473345437",
			:to => from_number,
			:body => "Wow did I just get a message from you? Is your zip #{from_zip}?"
			)
	end
end
