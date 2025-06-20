Given 'I am on the homepage' do
  visit('/')
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

Then('I should be on {word} page') do |whose|
  path = whose == 'my' ? Type.my_path : Type.your_path
  assert_match path, page.current_path
end

Then('I should be on the {word} page') do |string|
  assert_match "/#{string}", page.current_path
end
