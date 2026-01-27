# frozen_string_literal: true

When('I follow the {string} link') do |string|
  click_link(string, match: :prefer_exact)
end

When('I follow my sibling') do
  click_link('same nature')
end

When('I follow my friend') do
  click_link('same advice')
end

When('I choose my subtype') do
  Type.mine.subtypes.each do |x|
    click_link(x.link) and break if page.has_link?(x.link)
  end
end

When('I choose my episode') do
  click_link(Type.mine.depression)
end
