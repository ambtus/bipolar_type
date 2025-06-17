When('I follow the {string} link') do |string|
  click_link(string, match: :prefer_exact)
end
