Given('I have entered {string} for {string}') do |string, string2|
  visit('/cookies')
  fill_in string2, with: string
  click_button 'Save'
end
