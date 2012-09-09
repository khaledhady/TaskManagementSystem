Given /^user "(.*?)" manages "(.*?)" projects$/ do |arg1, arg2|
  user = User.find_by_email(arg1)
  arg2.to_i.times{user.projects << FactoryGirl.create(:project)}
  user.projects
  user.save
  puts user.projects.inspect
end
