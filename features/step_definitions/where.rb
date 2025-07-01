# frozen_string_literal: true

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
  type = whose == 'my' ? Type.my_type : Type.your_type
  assert_equal page.title, "BipolarType: #{type.title}"
end

Then('I should be on the {word} page') do |string|
  assert_match "/#{string}", page.current_path
end
