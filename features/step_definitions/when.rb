When('I follow the {string} link') do |string|
  click_link(string, match: :prefer_exact)
end

When('I follow the link for {word}') do |tla|
  subtype = Subtype.find_by_tla(tla)
  click_link(subtype.episode)
end
