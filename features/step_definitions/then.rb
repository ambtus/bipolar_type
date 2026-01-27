# frozen_string_literal: true

Then 'I should see {string}' do |string|
  expect(page).to have_text(string)
end

Then('{string} should link to {word}') do |string, word|
  expect(page).to have_link(string, href: /#{word}/)
end

Then('I should see the four wisdoms') do
  Mood.each do |x|
    expect(page).to have_text(x.wise)
  end
end

Then('I should see the four fools') do
  Mood.each do |x|
    expect(page).to have_text(x.foolish)
  end
end

Then('I should see the four realms') do
  Realm.each do |x|
    expect(page).to have_text(x.title)
  end
end

Then('I should see the {word} four subtypes') do |ordinal|
  Mood.send(ordinal).subtypes.each do |x|
    expect(page).to have_text(x.link)
  end
end

Then('I should see the four episodes') do
  Action.each do |x|
    expect(page).to have_text(x.episode)
  end
end

Then('my moods should be listed') do
  Type.mine.subtypes.each do |x|
    expect(page).to have_text(x.link)
  end
end

Then('my greens should be listed') do
  Type.mine.greens.each do |x|
    expect(page).to have_text(x.link)
  end
end
