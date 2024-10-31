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

Given('I am on the types page') do
  visit('/types')
end

Given('I am on the subtypes page') do
  visit('/subtypes')
end

Given('I am on the cycle page') do
  visit('/cycle')
end

Then('I should be on my page') do
  assert page.has_text?('BipolarType 15 of 24')
end

Then('I should NOT be on my page') do
  assert page.has_no_text?('BipolarType 15 of 24')
end
