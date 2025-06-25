Given('I have changed the word for {word} to {word}') do |original, mine|
  visit words_path
  fill_in original, with: mine
  click_button 'Save', match: :first
end

Given('I use a bookmark link to {word} page including {string}') do |word, cookies|
  url = case word
        when 'words'
          words_path
        when 'my'
          my_path
        when 'your'
          type_path(Type.your_path)
        end
  visit(url + '?' + cookies)
end
