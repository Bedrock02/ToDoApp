class TextsController < ApplicationController
	include Webhookable
	
	after_filter :set_header, only:[:messaging]
	skip_before_action :verify_authenticity_token

	def verify_user
	end

	def send_verification
		number = params[:format]
		account_sid = 'AC3126b43bc8d57aa5750bc123c75aabab'
		auth_token = 'ab465cea4dd39ee5bd577eab69adce53'
		@client = Twilio::REST::Client.new account_sid, auth_token
		@caller_id = @client.account.outgoing_caller_ids.create(:phone_number => number)
	end

	def messaging
		text_body = params[:Body]
		from_number = params[:From]

		create_task_for_user(from_number,text_body)
		
		@new_log = SmsLog.new(body: text_body, from: from_number)
		@new_log.save
		
		response = Twilio::TwiML::Response.new do |r|
			r.Message "You have just texted in your new Task. We will update your profile for you."
		end
		render_twiml(response)
	end

	def create_task_for_user(number,text)
		modified_format = number[2..-1]
		modified_format.insert(3,"-")
		modified_format.insert(7,"-")
		user = User.find_by_phone_number(modified_format)

		unless user.nil?
			task = Task.new(body:text)
			task.status_incomplete
			task.user = user
			task.save
		end 
	end
end
