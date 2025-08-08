# frozen_string_literal: true

Then 'I should see {}' do |string|
  assert page.has_text?(string)
end

Then('I should NOT see {}') do |string|
  assert page.has_no_text?(string)
end

Then('the {string} link should NOT be disabled') do |string|
  assert page.has_link?(string)
end

Then('{string} should be entered in {string}') do |text, field|
  assert page.has_field?(field, with: text)
end

Then('I should have a {word} link including {string}') do |name, snippet|
  assert page.has_link?(name, href: Regexp.new(snippet))
end

Then('my cookies should be empty') do
  assert cookies.to_hash.blank?
end

Then('all subtypes should be linked') do
  Subtype.each do |s|
    assert page.has_link?(s.size)
  end
end
