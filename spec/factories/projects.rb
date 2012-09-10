# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :project do
    sequence(:name) { |n| "MyString#{n}" }
    sequence(:identifier) {|n| "MyIdentifier#{n}"}
    start_date "2012-09-09"
    end_date "2012-09-09"
  end

  
end
