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

# account_sid = "AC3126b43bc8d57aa5750bc123c75aabab"
# 		auth_token = "ab465cea4dd39ee5bd577eab69adce53"
# 		@client = Twilio::REST::Client.new account_sid, auth_token


# 		@client.account.messages.create(
# 			:from => "+13473345437",
# 			:to => "+16467031728",
# 			:body => params[:q]
# 			)


class TextsController < ApplicationController
	include Webhookable
	
	after_filter :set_header

	skip_before_action :verify_authenticity_token

	def index
	end

	def messaging
		text_body = params[:Body]
		from_number = params[:From]

		@new_log = SmsLog.new(body: text_body, from: from_number)
		@new_log.save
		
		response = Twilio::TwiML::Response.new do |r|
			r.Message "Hi there it finally worked."
		end
		render_twiml(response)
	end
end
