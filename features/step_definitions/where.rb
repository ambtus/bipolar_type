Given 'I am on the homepage' do
  visit('/')
end

Given('I am on the first question page') do
  visit('/answers/Q1')
end

Given('I am on my page') do
  visit(my_path)
end

Given('I am on your page') do
  visit(type_path(Type.your_path))
end


Given('I am on the {word} page') do |url|
  visit("/#{url}")
end

Then('I should be on my page') do
  assert page.has_no_link?('Me')
end

Then('I should NOT be on my page') do
  assert page.has_link?('Me')
end

Then('I should be on a theory page') do
  assert_match "/types/", page.current_path
end

Then('I should be on the {word} page') do |string|
  assert_match "/#{string}", page.current_path
end
