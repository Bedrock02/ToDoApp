class TextsController < ApplicationController
	include Webhookable
	
	after_filter :set_header
	skip_before_action :verify_authenticity_token

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
