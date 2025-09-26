# frozen_string_literal: true

Then 'I should see {}' do |string|
  expect(page).to have_text(string)
end

Then 'I should NOT see {}' do |string|
  expect(page).to have_no_text(string)
end

Then('the {string} link should NOT be disabled') do |string|
  expect(page).to have_link(string)
end

Then('all subtypes should be linked') do
  Subtype.each do |x|
    expect(page).to have_link(x.link)
  end
end

Then('all {word} should be listed') do |what|
  case what
  when 'behaviors'
    Behavior.each do |x|
      expect(page).to have_text(x.words)
    end
  when 'externals', 'internals', 'realms'
    Realm.each do |x|
      expect(page).to have_text(x.send(what))
    end
  when 'attitudes', 'reactions', 'times'
    Attitude.each do |x|
      expect(page).to have_text(x.send(what))
    end
  when 'seasons', 'moods'
    Mood.each do |x|
      expect(page).to have_text(x.send(what.singularize))
    end
  else
    raise "need to define action for #{what}"
  end
end

Then('{word} {word} should be visible') do |whose, what|
  who = whose == 'my' ? Type.my_type : Type.your_type
  who.subtypes.each do |x|
    expect(page).to have_text(x.send(what.singularize))
  end
end

Then('{word} {word} should NOT be visible') do |whose, what|
  who = whose == 'my' ? Type.my_type : Type.your_type
  who.subtypes.each do |x|
    expect(page).to have_no_text(x.send(what.singularize))
  end
end

Then 'I should have {int} list items' do |int|
  expect(find_all('li').count).to be int
end
