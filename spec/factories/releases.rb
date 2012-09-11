# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :release do
    sequence(:version) { |n| "#{n}.0"}
    start_date "2012-09-11"
    end_date "2012-09-11"
  end
end
