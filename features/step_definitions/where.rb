# frozen_string_literal: true

Given 'I am on the homepage' do
  visit('/')
end

Given('I am on my page') do
  visit '/me'
end

Given('I am on the bipolar page') do
  visit '/cycle'
end

Given('I am on the type page') do
  visit '/signals'
end

Given('I am on the types page') do
  visit '/types'
end

Then('I should be on the homepage') do
  expect(page).to have_current_path('/')
end

Then('I should be on the {word} page') do |word|
  expect(page).to have_current_path(/#{word}/)
end

Then('I should be on my page') do
  expect(page).to have_current_path type_path(Type.mine.path)
end

Then('I should be on my sibling page') do
  expect(page).to have_current_path type_path(Type.mine.sibling.path)
end

Then('I should be on my friend page') do
  expect(page).to have_current_path type_path(Type.mine.friend.path)
end
