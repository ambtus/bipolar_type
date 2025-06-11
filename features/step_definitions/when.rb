When('I follow the {string} link') do |string|
  click_link(string)
end

When('I follow the last link') do
  click_link(all('a', visible: true).last.text)
end
