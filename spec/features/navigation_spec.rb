
require 'rails_helper'
include Warden::Test::Helpers
Warden.test_mode!

describe "Top Navigation" do
	context "User is not logged in" do
		it "should show all links except for logout" do
			visit '/'
			within('.nav') do
				expect(page).to have_content('ToDoList')
				expect(page).to have_content('My Profile')
				expect(page).to have_content('Verify Me')
				expect(page).to have_no_content('Logout')
			end
		end
	end

	context "User is logged in" do
		it "should show all links" do
		
			@user = FactoryGirl.create(:user)
			login_as(@user, :scope => :user)

			visit'/'
			within('.nav') do
				expect(page).to have_content('ToDoList')
				expect(page).to have_content('My Profile')
				expect(page).to have_content('Verify Me')
				expect(page).to have_content('Logout')
		
			end
		end
	end
end

Warden.test_reset!