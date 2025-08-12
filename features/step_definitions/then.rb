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
