# frozen_string_literal: true

When('I follow the {string} link') do |string|
  click_link(string, match: :prefer_exact)
end

When('I follow my sibling') do
  click_link('same cycle')
end

When('I follow my friend') do
  click_link('same advice')
end

When('I choose my {word} subtype') do |word|
  click_link(Type.mine.subtypes.send(word).wise)
end

When('I choose my episode') do
  click_link(Type.mine.depression)
end
