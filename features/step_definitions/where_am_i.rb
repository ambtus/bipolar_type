Given 'I am on the homepage' do
  visit('/')
end

Given('I am on the questions page') do
  visit('/answers/Q1')
end

Given('I am on my page') do
  visit('/me')
end

Given('I am on your page') do
  visit('/types/NSTF')
end

Given('I am on the theory page') do
  visit('/theory')
end

Then('I should be on my page') do
  assert page.has_no_link?('Me')
end

Then('I should NOT be on my page') do
  assert page.has_link?('Me')
end
