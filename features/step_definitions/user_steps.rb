Given /^I am on sign in page$/ do
  visit new_user_session_path
end

When /^I fill in "(.*?)" with "(.*?)"$/ do |arg1, arg2|
  fill_in arg1, :with => arg2
end

When /^I press "(.*?)"$/ do |arg1|
  click_link_or_button arg1
end

Then /^I should be on my projects page$/ do
  page.should have_content('Projects List')
end


