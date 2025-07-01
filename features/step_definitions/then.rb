# frozen_string_literal: true

Then 'I should see {word}' do |string|
  assert page.has_text?(string)
end

Then('I should NOT see {word}') do |string|
  assert page.has_no_text?(string)
end

Then('the {string} link should be disabled') do |string|
  assert page.has_no_selector?('a', text: /^#{string}$/)
end

Then('I should NOT see the default word for {word}') do |tla|
  subtype = Subtype.find_by(tla: tla)
  assert page.has_no_text?(subtype.action)
end

Then('the {string} link should NOT be disabled') do |string|
  assert page.has_link?(string)
end

Then('I should see {word} {word}') do |whose, whats|
  words = whose_whats(whose, whats)
  words.each do |text|
    assert page.has_text?(text)
  end
end

Then('I should NOT see {word} {word}') do |whose, whats|
  words = whose_whats(whose, whats)
  words.each do |text|
    assert page.find_all('#hide', text: text)
  end
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
