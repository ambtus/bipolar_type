When('I follow the {string} link') do |string|
  click_link(string)
end

When('I enter {string} for {string}') do |string, string2|
  fill_in string2, with: string
end

When('I press {string}') do |string|
  click_button string
end
