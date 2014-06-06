# Read about factories at https://github.com/thoughtbot/factory_girl
include Devise::TestHelpers

FactoryGirl.define do
  factory :user do
  	email "example@example.com"
  	password "example"
  	password_confirmation "example"
  end
end
