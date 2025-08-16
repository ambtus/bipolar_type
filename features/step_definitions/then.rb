# frozen_string_literal: true

Then 'I should see {}' do |string|
  assert page.has_text?(string)
end

Then('the {string} link should NOT be disabled') do |string|
  assert page.has_link?(string)
end

Then('all behaviors should be linked') do
  Behavior.each do |x|
    assert page.has_link?(x.link)
  end
end

Then('all behaviors should be listed') do
  Behavior.each do |x|
    assert page.has_text?(x.do_something)
  end
end

Then('{word} {word} should be visible') do |whose, what|
  who = whose == 'my' ? Type.my_type : Type.your_type
  who.behaviors.each do |x|
    assert page.has_text?(x.send(what.singularize))
  end
end

Then('{word} {word} should be clickable') do |whose, what|
  who = whose == 'my' ? Type.my_type : Type.your_type
  who.subtypes.each do |x|
    click_link(clickable(x, what), match: :first)
    click_link('Hide')
  end
end

def clickable(who, what)
  return who.flip.goal if what == 'subgoals'
  return who.episode if what == 'episodes'

  what.singularize
end
