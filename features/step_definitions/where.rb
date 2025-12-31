# frozen_string_literal: true

Given 'I am on the homepage' do
  visit('/')
end

Given('I am on the depression page') do
  visit('/depression')
end

Given('I am on my insomnia page') do
  visit('/insomnia.S')
end

Given('I am on my stress page') do
  visit('/stress.SN')
end

Given('I am on my type page') do
  visit type_path(Bipolar.mine.type.path)
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
  expect(page).to have_current_path type_path(Bipolar.mine.type.path)
end

Then('I should be on my bipolar page') do
  expect(page).to have_current_path bipolar_path(Bipolar.mine.path)
end

Then('I should be on my sibling page') do
  expect(page).to have_current_path bipolar_path(Bipolar.mine.sibling.path)
end

Then('I should be on my similar page') do
  expect(page).to have_current_path bipolar_path(Bipolar.mine.similar.path)
end

Then('I should be on my different page') do
  expect(page).to have_current_path bipolar_path(Bipolar.mine.different.path)
end

Then('I should be on my mimic page') do
  expect(page).to have_current_path bipolar_path(Bipolar.mine.mimic.path)
end
