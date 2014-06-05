# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :task do
    body "MyString"
    status "incomplete"
  end

  factory :compTask do
  	body "MyString"
  	status "complete"
  end
end
