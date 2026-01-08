# frozen_string_literal: true

Given 'I am on the homepage' do
  visit('/')
end

Given('I am on the basic page') do
  visit('/basic')
end

Given('I am on my ip page') do
  visit('/ip.i')
end

Given('I am on my ep page') do
  visit('/ep.iS')
end

Given('I am on my ej page') do
  visit('/ej.iSF')
end

Then('I should be on my ej page') do
  expect(page).to have_current_path('/ej.iSF')
end

Given('I am on my ij page') do
  visit('/ij.iSFT')
end

Then('I should be on my ij page') do
  expect(page).to have_current_path('/ij.iSFT')
end

Given('I am on my bipolar page') do
  visit '/me'
end

Given('I am on a behavior page') do
  visit behavior_path(Behavior.iSp.path)
end

Given('I am on another behavior page') do
  visit behavior_path(Behavior.eNj.path)
end

Given('I am on the behaviors page') do
  visit behaviors_path
end

Then('I should be on the {word} page') do |word|
  expect(page).to have_current_path(/#{word}/)
end

Then('I should be on my type page') do
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

