# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Type, type: :model do
  it 'has a path' do
    expect(described_class.first.path).to eq 'eFSpiTNj'
  end

  it 'has a title' do
    expect(described_class.third.title).to eq 'eFSpiNTj'
  end

  describe 'find by subtypes in any order' do
    4.times do |i|
      it "can find my type by my subtypes rotated by #{i}" do
        expect(described_class.bp2(described_class.my_type.subtypes.rotate(i)[0,
3])).to be described_class.my_type
      end
    end
  end

end
