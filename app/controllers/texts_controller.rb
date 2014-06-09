
class TextsController < ApplicationController
	# account_sid = AC02a8319fb7577ece4907235b1df4c940
	# auth_token = 411e76923ff005f4d6a6bdc4fb4d33a7 	
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
end
