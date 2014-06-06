class Task < ActiveRecord::Base
	belongs_to :user
	validates :body, presence: true

	def set_body(newText)
		self.body = newText
		self.save
	end

	def status_complete
		self.status = "complete"
		self.save
	end

	def status_incomplete
		self.status = "incomplete"
		self.save
	end

	def flip_status
		if self.status == "incomplete"
			self.status_complete
		else
			self.status_incomplete
		end
	end
end
