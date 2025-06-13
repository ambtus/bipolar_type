When('I follow the {string} link') do |string|
  click_link(string, match: :prefer_exact)
end

When('I follow the last link') do
  click_link(all('a', visible: true).last.text)
end
