# frozen_string_literal: true

When('I follow the {string} link') do |string|
  click_link(string, match: :prefer_exact)
end

When('I follow {word} links') do |word|
  who = word == 'my' ? Type.my_type : Type.your_type
  who.attitudes.each do |a|
    click_link(a.name)
  end
end

When('I follow {word} path') do |word|
  who = word == 'my' ? Type.my_type : Type.your_type
  click_link(who.path)
end

When('I click the button') do
  click_button
end

When('I click the {string} button') do |string|
  click_button string
end

When('I click the {string} button {int} times') do |string, int|
  int.times { click_button string }
end
