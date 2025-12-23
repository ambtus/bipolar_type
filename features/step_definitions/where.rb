# frozen_string_literal: true

Given 'I am on the homepage' do
  visit('/')
end

Given('I am on {word} type page') do |whose|
  type = whose == 'my' ? Type.my_type : Type.your_type
  visit type_path(type.path)
end

When('I am on a bad type page') do
  visit type_path('old/type')
end

When('I am on a bad nature page') do
  visit nature_path('old_nature')
end

Given('I am on the {word} page') do |url|
  visit("/#{url}")
end

Then('I should be on {word} page') do |whose|
  type = whose == 'my' ? Type.my_type : Type.your_type
  assert_equal page.title, "BipolarType: #{type.title}"
end

Then('I should be on {word} {word} page') do |whose, what|
  if whose == 'the'
    expect(page).to have_current_path("/#{what}")
  else
    who = whose == 'my' ? Type.my_type : Type.your_type
    expect(page).to have_title(who.send(what).title)
  end
end
