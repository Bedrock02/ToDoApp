require 'rails_helper'
require 'devise'
include Devise::TestHelpers

describe User do
	before(:each) do
		@user = FactoryGirl.create(:user)
		sign_in @user
	end

	describe 'new' do
		it 'has an email' do
			@user.email.should be_present
		end
	end
end
