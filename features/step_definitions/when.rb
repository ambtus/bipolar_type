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

When('I click on my subtype') do
  Type.mine.subtypes.each do |x|
    click_link(x.link) and break if page.has_link?(x.link)
  end
end

When('I click on my skew') do
  click_link(Type.mine.skew.link)
end
