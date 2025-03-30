Given('I have entered {string} for {string}') do |cookie, id|
  visit('/cookies')
  fill_in id, with: cookie
  click_button 'Save', match: :first
end
