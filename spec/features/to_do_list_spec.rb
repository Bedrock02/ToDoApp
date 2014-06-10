require 'rails_helper'
include Warden::Test::Helpers
Warden.test_mode!

describe "ToDo List" do
	
	before(:each) do
		@user = FactoryGirl.create(:user)
		login_as(@user, :scope => :user)
	end

	context "New user logged into account" do
		it "should not display any tasks" do
			visit '/'
			expect(page).to have_no_css(".to-do-tasks")
			expect(page).to have_content 'You currently do not have any Tasks in your ToDoList!'
		end
	end

	context "User that has a task" do
		it "should display the task" do
			task = FactoryGirl.create(:task)
			@user.tasks << task
			@user.save

			visit '/'
			expect(page).to have_css(".to-do-tasks")
			within(".to-do-tasks") do
				expect(page).to have_css(".task-description")
			end
		end
	end
	Warden.test_reset!
end