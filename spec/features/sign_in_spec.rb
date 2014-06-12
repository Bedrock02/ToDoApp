require 'rails_helper'
describe "Logging in a User" do
	
	before(:each) do
		@user = FactoryGirl.create(:user)
		visit '/'
	end
	
	context "User is able to log into the application" do
		it "Shows user's ToDo List" do		
			within('#new_user') do
				fill_in 'Email', with: @user.email
				fill_in 'Password', with: @user.password
			end
			click_button('Sign in')

			expect(page).to have_content 'ToDo List'
		end
	end

	context "User enters wrong credentials" do
		it "Does not log in user" do
			within('#new_user') do
				fill_in 'Email', with: @user.email
				fill_in 'Password', with: "notmypassword"
			end
			click_button('Sign in')

			expect(page).to have_content 'Sign in'
			within('#new_user'){
				expect(page).to have_content 'Email'
				expect(page).to have_content 'Password'
			}
		end
	end
end
