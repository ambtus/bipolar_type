Then('show me the page') do
  save_and_open_page
end

Then 'I should see {string}' do |string|
  assert page.has_text?(string)
end

Then('I should NOT see {string}') do |string|
  assert page.has_no_text?(string)
end

Then('the {string} link should be disabled') do |string|
  assert page.has_no_link?(string)
end

Then('the {string} link should NOT be disabled') do |string|
  assert page.has_link?(string)
end

Then('I should see {string} before {string}') do |string, string2|
  regexp = Regexp.new(string + '.*' + string2)
  Rails.logger.debug "regexp: #{regexp}"
  assert page.has_text?(regexp)
end

Then('I should NOT see {string} before {string}') do |string, string2|
  regexp = Regexp.new(string + '.*' + string2)
  assert page.has_no_text?(regexp)
end

Then('I should see all {word} {word}') do |klass, meth|
  meth = meth.singularize
  result = klass.constantize.all.map(&meth.to_sym)
  Rails.logger.debug result
  result.each do |text|
    assert page.has_text?(text)
  end
end

Then('{string} should be entered in {string}') do |text, field|
  assert page.has_field?(field, with: text)
end

Then('I should have a {word} link including {string}') do |name, snippet|
  assert page.has_link?(name, href: Regexp.new(snippet))
end
