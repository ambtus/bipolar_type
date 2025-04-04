Given 'I am on the homepage' do
  visit('/')
end

Given('I am on the questions page') do
  visit('/answers/Q1')
end

Given('I am on the cookies page') do
  visit('/cookies')
end

Given('I am on my page') do
  visit('/me')
end

Given('I am on the attitudes page') do
  visit('/attitudes')
end

Given('I am on the realms page') do
  visit('/realms')
end

Given('I am on the cycle page') do
  visit('/cycle')
end

Then('I should be on my page') do
  assert page.has_no_link?('Me')
end

Then('I should NOT be on my page') do
  assert page.has_link?('Me')
end
