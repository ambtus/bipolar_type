# frozen_string_literal: true

Then 'I should see {string}' do |string|
  expect(page).to have_text(string)
end

Then('{string} should link to {word}') do |string, word|
  expect(page).to have_link(string, href: /#{word}/)
end

Then('all internals should be linked') do
  Realm.all.map(&:internal).each do |x|
    expect(page).to have_link(x)
  end
end

Then('three internals should be linked') do
  Realm.without(Realm.S).map(&:internal).each do |x|
    expect(page).to have_link(x)
  end
end

Then('two types should be linked') do
  %w[spiritual material].each do |x|
    expect(page).to have_link(x)
  end
end

Then('two bipolars should be linked') do
  %w[fight flee].each do |x|
    expect(page).to have_link(x)
  end
end

Then('my moods should be listed') do
  Bipolar.mine.subtypes.each do |x|
    expect(page).to have_text(x.link)
  end
end

Then('my dos should be linked') do
  Bipolar.mine.dos.each do |x|
    expect(page).to have_link(x.link)
  end
end

Then('my donts should be linked') do
  Bipolar.mine.donts.each do |x|
    expect(page).to have_link(x.link)
  end
end

Then('I should see the first breadcrumb') do
  expect(page).to have_link('home', href: root_path)
end

Then('I should see the second breadcrumb') do
  expect(page).to have_link('depression', href: depression_path)
end

Then('I should see the third breadcrumb') do
  expect(page).to have_link('insomnia', href: insomnia_path('S'))
end

Then('I should see the fourth breadcrumb') do
  expect(page).to have_link('mania', href: mania_path('SN'))
end

Then('I should see the fifth breadcrumb') do
  expect(page).to have_link('type', href: type_path(Bipolar.mine.type.path))
end

Then('I should see a generic description') do
  expect(page).to have_text(Behavior.iSp.generic)
end

Then('I should see a focus') do
  expect(page).to have_text(Behavior.iSp.focus)
end

Then('I should see a technical description') do
  expect(page).to have_text(Behavior.iSp.technical)
end

Then('I should see another generic description') do
  expect(page).to have_text(Behavior.eNj.generic)
end

Then('I should see another focus') do
  expect(page).to have_text(Behavior.eNj.focus)
end

Then('I should see another technical description') do
  expect(page).to have_text(Behavior.eNj.technical)
end
