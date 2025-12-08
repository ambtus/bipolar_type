# frozen_string_literal: true

When('I follow the {string} link') do |string|
  click_link(string, match: :prefer_exact)
end

When('I follow {word} subtype(s)') do |count|
  click_link Realm.first.subtypes.first.title
  click_link Realm.second.subtypes.second.title if count == 'two'
end

When('I follow {word} links') do |word|
  who = word == 'my' ? Type.my_type : Type.your_type
  who.subtypes[0, 3].each do |x|
    click_link(x.title)
  end
  click_link who.path
end

When('I follow {word}') do |word|
  click_link(word.singularize.capitalize.constantize.title)
end

When('I follow {word} path') do |word|
  who = word == 'my' ? Type.my_type : Type.your_type
  click_link who.path
end

When('I follow {word} nature') do |word|
  who = word == 'my' ? Type.my_type : Type.your_type
  click_link who.nature.link
end
