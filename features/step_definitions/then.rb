# frozen_string_literal: true

Then 'I should see {string}' do |string|
  expect(page).to have_text(string)
end

Then 'I should NOT see {string}' do |string|
  expect(page).to have_no_text(string)
end

Then('the {string} link should be disabled') do |string|
  expect(page).to have_no_link(string)
end

Then('the {string} link should NOT be disabled') do |string|
  expect(page).to have_link(string)
end

Then('{word} {word} should be linked') do |whose, what|
  if whose == 'all'
    what.singularize.capitalize.constantize.all.each do |x|
      expect(page).to have_link(x.title)
    end
  elsif what == 'subtypes'
    who = whose == 'my' ? Type.my_type : Type.your_type
    who.subtypes.each do |x|
      expect(page).to have_link(x.title)
    end
  else
    raise "#{whose} #{what} doesn't match a test"
  end
end

Then('{word} subtypes should NOT be linked') do |whose|
  who = whose == 'my' ? Type.my_type : Type.your_type
  who.subtypes.each do |x|
    expect(page).to have_no_link(x.title)
  end
end

Then 'I should have {int} subtype links' do |int|
  expect(all('a.subtype').count).to be int
end
