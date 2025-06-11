Given('I have changed the word for {string} to {string}') do |original, mine|
  visit('/words')
  fill_in original, with: mine
  click_button 'Save', match: :first
end

Given('I use a bookmark link to {word} page including {string}') do |whose, snippet|
  url = whose=='my' ? 'types/FTNS' : '/types/NSTF'
  visit(url + '?' + snippet)
end
