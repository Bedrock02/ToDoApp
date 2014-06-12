require 'rails_helper'
describe "User Registration" do
	
	before(:each) do
		@new_user = FactoryGirl.build(:user)
		visit '/'
	end

	context "User fills everything out and signs up" do
		it "Allows for a new user to register" do
			click_on 'Sign up'
			expect(page).to have_content 'Sign up'
			
			within('#new_user') do
				fill_in 'Email', with: @new_user.email
				fill_in 'Phone number', with: @new_user.phone_number
				fill_in 'Password', with: @new_user.password
				fill_in 'Password confirmation', with: @new_user.password_confirmation
			end
			
			click_button('Sign up')
			expect(page).to have_content 'ToDo List'
		end
	end

	context "User leaves out password" do
		it "Doesn't register new user and shows error" do
		
			click_on 'Sign up'
			expect(page).to have_content 'Sign up'

			within('#new_user') do
				fill_in 'Email', with: @new_user.email
				fill_in 'Phone number', with: @new_user.phone_number
			end
			
			click_button('Sign up')
			expect(page.has_css?('#error_explanation')).to be == true
			expect(page.has_css?('.field_with_errors')).to be == true


			within('#error_explanation'){
				expect(page).to have_content 'Password can\'t be blank'
			}
		end
	end


	context "User leaves out email" do
		it "Doesn't register new user and shows error" do
			
			click_on 'Sign up'
			expect(page).to have_content 'Sign up'

			within('#new_user') do
				fill_in 'Phone number', with: @new_user.phone_number
				fill_in 'Password', with: @new_user.password
				fill_in 'Password confirmation', with: @new_user.password_confirmation
			end
			
			click_button('Sign up')
			
			expect(page).to have_content 'Sign up'			
			expect(page.has_css?('#error_explanation')).to be == true
			expect(page.has_css?('.field_with_errors')).to be == true


			within('#error_explanation'){
				expect(page).to have_content 'Email can\'t be blank'
			}
		end
	end

	context "User leaves out password" do
		it "Registers a user without a phone number" do
	
			click_on 'Sign up'
			expect(page).to have_content 'Sign up'

			within('#new_user') do
				fill_in 'Email', with: @new_user.email
				fill_in 'Password', with: @new_user.password
				fill_in 'Password confirmation', with: @new_user.password_confirmation
			end
			
			click_button('Sign up')
			
			expect(page).to have_content 'ToDo List'			
		end
	end

	context "User doesn't fill anything out" do
		it "Doesn't register the user" do

			click_on 'Sign up'
			expect(page).to have_content 'Sign up'
			click_button('Sign up')
			
			expect(page).to have_content 'Sign up'			
			expect(page.has_css?('#error_explanation')).to be == true
			expect(page.has_css?('.field_with_errors')).to be == true

		end
	end

end