# frozen_string_literal: true

Given 'I am on the homepage' do
  visit('/')
end

Given('I am on {word} type page') do |whose|
  type = whose == 'my' ? Type.my_type : Type.your_type
  visit type_path(type.path)
end

Given('I am on the {word} page') do |url|
  visit("/#{url}")
end

Then('I should be on {word} page') do |whose|
  type = whose == 'my' ? Type.my_type : Type.your_type
  assert_equal page.title, "BipolarType: #{type.title}"
end
