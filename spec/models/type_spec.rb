require 'rails_helper'

RSpec.describe Type, type: :model do
  it 'can be sorted' do
    expect(Type.sort_by('bored')).not_to eq Type.sort_by('agitated')
  end

  it 'sorts bored correctly' do
    first_six = Type.sort_by('bored')[0,6]
    subtypes = first_six.map(&:episodes).map(&:first)
    expect(subtypes.first.unhappy).to eq 'bored'
    expect(subtypes.uniq.count).to eq 1
  end

  it 'sorts anxious correctly' do
    first_six = Type.sort_by('anxious')[0,6]
    subtypes = first_six.map(&:episodes).map(&:second)
    expect(subtypes.first.unhappy).to eq 'anxious'
    expect(subtypes.uniq.count).to eq 1
  end
end
