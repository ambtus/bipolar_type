When('I follow the {string} link') do |string|
  click_link(string, match: :prefer_exact)
end

When('I follow {word} links') do |word|
  who = word == 'my' ? Type.my_type : Type.your_type
  subtypes = who.problems
  subtypes.sample(3).each do |s|
    click_link(s.episode)
  end
end
