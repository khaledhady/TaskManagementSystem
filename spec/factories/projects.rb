# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :project do
    name "MyString"
    identifier "MyString"
    start_date "2012-09-09"
    end_date "2012-09-09"
  end
end
