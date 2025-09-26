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
  when 'externals'
    Realm.each do |x|
      expect(page).to have_text(x.externals)
    end
  when 'internals'
    Realm.each do |x|
      expect(page).to have_text(x.internals)
    end
  when 'attitudes'
    Attitude.each do |x|
      expect(page).to have_text(x.do_something)
    end
  when 'reactions'
    Attitude.each do |x|
      expect(page).to have_text(x.react)
    end
  when 'seasons'
    Mood.each do |x|
      expect(page).to have_text(x.season)
    end
  when 'times'
    Attitude.each do |x|
      expect(page).to have_text(x.time_of_day)
    end
  when 'realms'
    Realm.each do |x|
      expect(page).to have_text(x.name)
    end
  when 'moods'
    Mood.each do |x|
      expect(page).to have_text(x.description)
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
