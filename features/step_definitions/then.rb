# frozen_string_literal: true

Then 'I should see {}' do |string|
  assert page.has_text?(string)
end

Then 'I should NOT see {}' do |string|
  assert page.has_no_text?(string)
end

Then('the {string} link should NOT be disabled') do |string|
  assert page.has_link?(string)
end


Then('all attitudes should be linked') do
  Attitude.each do |x|
    assert page.has_text?(x.name)
  end
end

Then('all behaviors should be listed') do
  Behavior.each do |x|
    assert page.has_text?(x.advice)
  end
end

Then('{word} {word} should be visible') do |whose, what|
  who = whose == 'my' ? Type.my_type : Type.your_type
  who.send(what).each do |x|
    assert page.has_text?(x.name)
  end
end

Then('{word} {word} should NOT be visible') do |whose, what|
  who = whose == 'my' ? Type.my_type : Type.your_type
  who.send(what).each do |x|
    assert page.has_no_text?(x.name)
  end
end

Then('all episodes should be listed') do
  Attitude.each do |x|
    assert page.has_text?(x.episode)
  end
end

Then('all reactions should be listed') do
  Attitude.each do |x|
    assert page.has_text?(x.react)
  end
end

Then 'I should have {int} li elements' do |int|
  expect(find_all('li').count).to be int
end
