# frozen_string_literal: true

When('I follow the {string} link') do |string|
  click_link(string, match: :prefer_exact)
end

When('I choose my {word} red') do |word|
  click_link(Type.mine.reds.send(word).wise)
end
