# frozen_string_literal: true

When('I follow the {string} link') do |string|
  click_link(string, match: :prefer_exact)
end

When('I follow my sibling') do
  click_link(Type.my_type.sibling.link)
end

When('I follow my similar') do
  click_link(Type.my_type.similar.link)
end

When('I follow my different') do
  click_link(Type.my_type.different.link)
end

When('I follow my mimic') do
  click_link(Type.my_type.mimic.link)
end

When('I follow my first do') do
  click_link(Type.my_type.dos.first.link)
end

When('I follow my first dont') do
  click_link(Type.my_type.donts.first.link)
end
