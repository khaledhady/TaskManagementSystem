# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :project do
    sequence(:name) { |n| "MyString#{n}" }
    sequence(:identifier) {|n| "MyIdentifier#{n}"}
    start_date "2012-09-09"
    end_date "2012-09-09"
  end

  factory :project_with_user, :parent => :project do |project|
    project.after_create { |p| FactoryGirl(:user, :project => p)}
  end
end
