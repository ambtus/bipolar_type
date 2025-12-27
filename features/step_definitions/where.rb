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

Given('I am on my mania page') do
  visit('/mania.SN')
end

Given('I am on my nature page') do
  visit nature_path(Type.my_type.nature.path)
end

Given('I am on my type page') do
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

Then('I should be on my nature page') do
  expect(page).to have_current_path nature_path(Type.my_type.nature.path)
end

Then('I should be on my type page') do
  expect(page).to have_current_path type_path(Type.my_type.path)
end

Then('I should be on my sibling page') do
  expect(page).to have_current_path type_path(Type.my_type.sibling.path)
end

Then('I should be on my similar page') do
  expect(page).to have_current_path type_path(Type.my_type.similar.path)
end

Then('I should be on my different page') do
  expect(page).to have_current_path type_path(Type.my_type.different.path)
end

Then('I should be on my mimic page') do
  expect(page).to have_current_path type_path(Type.my_type.mimic.path)
end
