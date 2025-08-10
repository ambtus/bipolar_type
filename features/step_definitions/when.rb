# frozen_string_literal: true

When('I follow the {string} link') do |string|
  click_link(string, match: :prefer_exact)
end

When('I press the {string} button') do |string|
  click_button string
end

When('I follow {word} links') do |word|
  who = word == 'my' ? Type.my_type : Type.your_type
  who.subtypes.sample(3).each do |s|
    click_link(s.link)
  end
end

When('I save blank for {word}') do |word|
  fill_in word, with: ''
  click_button word
end
