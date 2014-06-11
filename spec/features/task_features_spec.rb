require 'rails_helper'
include Warden::Test::Helpers
Warden.test_mode!

describe "Task features" do
	
	before(:each) do
		@user = FactoryGirl.create(:user)
		@task = FactoryGirl.create(:task)
		@user.tasks << @task
		@user.save
		login_as(@user, scope: :user)
		visit '/'
	end

	context "A new Task is created" do
		
		it "should display a button to mark complete" do
			within('.to-do-tasks') do
				expect(page).to have_content 'Mark Complete'
			end
		end

		it "should contain a delete button" do
			within('.to-do-tasks') do
				expect(page).to have_css('.glyphicon-trash')
			end
		end
		
		it "should contain an edit button" do
			within('.to-do-tasks') do
				expect(page).to have_css('.glyphicon-pencil')
			end
		end
	end

	context "Marks task as complete" do
		it "task should be complete" do
			click_link 'Mark Complete'
			expect(page).to have_content 'Status: complete'
			expect(page).to have_content 'Mark Incomplete'
		end

		it "should not be able to edit" do
			click_link 'Mark Complete'
			expect(page).to have_no_css('.glyphicon-pencil')
		end
	end

	context "User edits existing Task" do
		it "should edit the body of a task" do
			click_link('', href: edit_task_path(@task))
			expect(page).to have_content "Editing task"

			new_task = "This is my edited task"
			fill_in "Body", with: new_task
			click_button "Update Task"

			expect(page).to have_content 'ToDo List'
			expect(page).to have_content new_task
		end
	end

	context "User deletes existing Task" do
		it "should be deleted from ToDo List" do
			expect(page).to have_content 'ToDo List'
			click_link('', href: "/tasks/#{@task.id}")
			click_button('OK')

			expect(page).to have_no_content "#{@task.body}"
		end
	end
end
Warden.test_reset!