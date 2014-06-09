# Read about factories at https://github.com/thoughtbot/factory_girl
FactoryGirl.define do
  factory :user do
  	email "example@example.com"
  	phone_number "555-555-5555"
  	password "thisisareallybadpassowrd"
  	password_confirmation "thisisareallybadpassowrd"
  end
end