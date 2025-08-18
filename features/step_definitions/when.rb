# frozen_string_literal: true

When('I follow the {string} link') do |string|
  click_link(string, match: :prefer_exact)
end

When('I follow {word} links') do |word|
  who = word == 'my' ? Type.my_type : Type.your_type
  who.behaviors.each do |b|
    click_link(b.link)
  end
  click_link(who.title)
end

When('I click the button') do
  click_button
end
