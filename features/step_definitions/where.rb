# frozen_string_literal: true

Given 'I am on the homepage' do
  visit('/')
end

Given('I am on the basic page') do
  visit('/basic')
end

Given('I am on my morning page') do
  visit('/morning.i')
end

Given('I am on my midday page') do
  visit('/midday.iS')
end

Given('I am on my afternoon page') do
  visit('/afternoon.iSF')
end

Then('I should be on my afternoon page') do
  expect(page).to have_current_path('/afternoon.iSF')
end

Given('I am on my evening page') do
  visit('/evening.iSFT')
end

Then('I should be on my evening page') do
  expect(page).to have_current_path('/evening.iSFT')
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

Then('I should be on my mimic page') do
  expect(page).to have_current_path type_path(Type.mine.mimic.path)
end
