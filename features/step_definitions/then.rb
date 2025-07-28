# frozen_string_literal: true

Then 'I should see {}' do |string|
  assert page.has_text?(string)
end

Then('I should NOT see {}') do |string|
  assert page.has_no_text?(string)
end

Then('the {string} link should be disabled') do |string|
  assert page.has_no_selector?('a', text: /^#{string}$/)
end

Then('the link for {word} should be disabled') do |word|
  thing = Attitude.find(word) || Realm.find(word)
  assert page.has_no_selector?('a', text: /^#{thing.name}$/)
end

Then('the {string} link should NOT be disabled') do |string|
  assert page.has_link?(string)
end

Then('the link for {word} should NOT be disabled') do |word|
  thing = Attitude.find(word) || Realm.find(word)
  assert page.has_link? thing.name
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

Then('all types should be linked') do
  Type.each do |t|
    assert page.has_link?(t.title, href: Regexp.new(t.path))
  end
end
