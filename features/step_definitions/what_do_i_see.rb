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

Then('I should see {string} within {string}') do |string, string2|
  assert page.has_field?(string2, with: string)
end

Then('show me the page') do
  save_and_open_page
end

Then('I should see {string} before {string}') do |string, string2|
  regexp = Regexp.new(string + '.*' + string2)
  Rails.logger.debug "regexp: #{regexp}"
  assert page.has_text?(regexp)
end

Then('I should see all subtypes') do
  Subtype.each do |s|
    assert page.has_text?(s.symbol)
  end
end

Then('the link {string} should include {string}') do |string, string2|
  href = page.find_link(string)['href']
  assert_match string2, href
end

Then('there should be {int} answer links') do |int|
  links = page.all('a')
  answer_links = links.select{|l| l[:href].match 'answer'}
  assert_equal int, answer_links.count
end
