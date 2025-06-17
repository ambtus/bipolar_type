Given('I have changed the word for {word} to {word}') do |original, mine|
  visit words_path
  fill_in original, with: mine
  click_button 'Save', match: :first
end

Given('I use a bookmark link to {word} page including {string}') do |whose, snippet|
  url = whose=='my' ? my_path : type_path(Type.your_path)
  visit(url + '?' + snippet)
end
