# frozen_string_literal: true

Given 'I am on the homepage' do
  visit('/')
end

Given('I am on my page') do
  visit '/me'
end

Given('I am on the theory page') do
  visit '/theory'
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

Then('I should be on my similar page') do
  expect(page).to have_current_path type_path(Type.mine.similar.path)
end

Then('I should be on my different page') do
  expect(page).to have_current_path type_path(Type.mine.different.path)
end
