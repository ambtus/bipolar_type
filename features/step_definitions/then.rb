# frozen_string_literal: true

Then 'I should see {string}' do |string|
  expect(page).to have_text(string)
end

Then('{string} should link to {word}') do |string, word|
  expect(page).to have_link(string, href: /#{word}/)
end

Then('two types should be linked') do
  %w[i e].each do |x|
    expect(page).to have_link(x)
  end
end

Then('all realms should be linked') do
  Action.ip.behaviors.each do |x|
    expect(page).to have_link(x.link)
  end
end

Then('three realms should be linked') do
  Action.ep.behaviors.each do |x|
    next if x.realm == Realm.S
    expect(page).to have_link(x.link)
  end
end

Then('two realms should be linked') do
  ['eNj', 'eTj'].each do |x|
    expect(page).to have_link(x)
  end
end

Then('one realm should be linked') do
  expect(page).to have_link('iNj')
end

Then('my moods should be listed') do
  Type.mine.subtypes.each do |x|
    expect(page).to have_text(x.link)
  end
end

Then('my dos should be listed') do
  Type.mine.dos.each do |x|
    expect(page).to have_text(x.link)
  end
end

Then('my donts should be listed') do
  Type.mine.donts.each do |x|
    expect(page).to have_text(x.link)
  end
end

Then('I should see the first breadcrumb') do
  expect(page).to have_link('home', href: root_path)
end

Then('I should see the second breadcrumb') do
  expect(page).to have_link('i', href: basic_path)
end

Then('I should see the third breadcrumb') do
  expect(page).to have_link('S', href: ip_path('i'))
end

Then('I should see the fourth breadcrumb') do
  expect(page).to have_link('F', href: ep_path('iS'))
end

Then('I should see the fifth breadcrumb') do
  expect(page).to have_link('T', href: ej_path('iSF'))
end

Then('I should see the sixth breadcrumb') do
  expect(page).to have_link('N', href: ij_path('iSFT'))
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
