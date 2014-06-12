require 'rails_helper'

describe "User must be authenticated first"  do
	
	context "Visits Root of Application" do
		it "Shows the Sign in form" do
			visit '/tasks'

			expect(page).to have_content 'Sign in'
			within('#new_user'){
				expect(page).to have_content 'Email'
				expect(page).to have_content 'Password'
			}
		end
	end
	
	context "User Attempts to create a new task before signing in" do
		it "redirects to root and shows Sign in form" do
			visit new_task_path
			expect(page).to have_content 'Sign in'
			
			within('#new_user'){
				expect(page).to have_content 'Email'
				expect(page).to have_content 'Password'
			}
		end
	end

	context "User Attempts to edit profile without signing in" do
		it "redirects to root and shows Sign in form" do
			visit new_task_path
			expect(page).to have_content 'Sign in'
			
			within('#new_user'){
				expect(page).to have_content 'Email'
				expect(page).to have_content 'Pass'
			}
		end
	end
end
