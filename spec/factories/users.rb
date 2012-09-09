# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :user do
    sequence(:name) { |n| "MyName#{n}" } 
    role "MyRole"
    sequence(:email) { |n| "foo#{n}@example.com" } 
    password 'MyPass'
    password_confirmation 'MyPassConfirm'
  end
end
