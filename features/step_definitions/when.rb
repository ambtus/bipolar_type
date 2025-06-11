When('I follow the {string} link') do |string|
  click_link(string)
end

When('I follow the last link') do
  click_link(all('a', visible: true).last.text)
end

When('I enter {string} for {string}') do |string, string2|
  fill_in string2, with: string
end

When('I press {string}') do |string|
  click_button string, match: :first
end
