# frozen_string_literal: true

Then 'I should see {string}' do |string|
  expect(page).to have_text(string)
end

Then 'I should NOT see {string}' do |string|
  expect(page).to have_no_text(string)
end

Then('the {string} link should be disabled') do |string|
  expect(page).to have_no_link(string, exact: true)
end

Then('the {string} link should NOT be disabled') do |string|
  expect(page).to have_link(string)
end

Then('{word} {word} should be linked') do |whose, what|
  if whose == 'all'
    if what == 'concepts'
      [Realm, Mood, Subtype, Attitude, Behavior].each do |x|
        expect(page).to have_link(x.title)
      end
    else
      what.singularize.capitalize.constantize.each do |x|
        expect(page).to have_link(x.title, exact: true)
      end
    end
  elsif %w[subtypes behaviors nature family].include? what
    who = whose == 'my' ? Type.my_type : Type.your_type
    if what == 'nature'
      expect(page).to have_link(who.nature.link, exact: true)
    else
      who.send(what).each do |x|
        if what == 'behaviors'
          expect(page).to have_link(x.link, exact: true)
        else
          expect(page).to have_link(x.title, exact: true)
        end
      end
    end
  else
    raise "#{whose} #{what} doesn't match a test"
  end
end

Then('all links should work') do
  current = page.current_path
  links = page.all('a:not(.hover-link)').map(&:text) - %w[Introduction Cycle Natures Theory Types]
  Rails.logger.debug { "links: #{links}" }
  links.each do |title|
    Rails.logger.debug { "following #{title}" }
    click_link(title)
    assert_equal "BipolarType: #{title}", page.title
    visit current
  end
end

Then('{word} {word} should NOT be linked') do |whose, what|
  raise "#{whose} #{what} doesn't match a test" unless %w[subtypes behaviors nature].include? what

  who = whose == 'my' ? Type.my_type : Type.your_type
  if what == 'nature'
      expect(page).to have_no_link(who.nature.link, exact: true)
  else
    who.send(what).each do |x|
      if what == 'behaviors'
        expect(page).to have_no_link(x.link, exact: true)
      else
        expect(page).to have_no_link(x.title, exact: true)
      end
    end
  end
end

Then 'I should have {int} subtype links' do |int|
  expect(all('a.subtype').count).to be int
end

Then('I should be on {word} nature page') do |whose|
  who = whose == 'my' ? Type.my_type : Type.your_type
  expect(page).to have_title(who.nature.title)
end
