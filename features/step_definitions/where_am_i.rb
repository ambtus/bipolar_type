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
