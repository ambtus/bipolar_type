# frozen_string_literal: true

When('I follow the {string} link') do |string|
  click_link(string, match: :prefer_exact)
end

When('I follow my sibling') do
  click_link(Type.mine.sibling.link)
end

When('I follow my similar') do
  click_link(Type.mine.similar.link)
end

When('I follow my different') do
  click_link(Type.mine.different.link)
end

When('I follow my first do') do
  click_link(Type.mine.dos.first.link)
end

When('I follow my first dont') do
  click_link(Type.mine.donts.first.link)
end
