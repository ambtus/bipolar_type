# frozen_string_literal: true

When('I follow the {string} link') do |string|
  click_link(string, match: :prefer_exact)
end

When('I follow my sibling') do
  click_link('yellow')
end

When('I follow my similar') do
  click_link('green')
end

When('I follow my different') do
  click_link('red')
end

When('I click on my {word} subtype') do |ordinal|
  click_link(Type.mine.subtypes.send(ordinal))
end

When('I click on my skew') do
  click_link(Type.mine.skew)
end
