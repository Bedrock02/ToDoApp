module ApplicationHelper

	def mark_as_helper(status)
		if status == "incomplete"
			"Mark Complete"
		else
			"Mark Incomplete"
		end
	end

	def no_tasks(user)
		unless user.tasks.empty?
			false
		else
			true
		end
	end
end
