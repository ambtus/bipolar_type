# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Type, type: :model do
  it 'has a path' do
    expect(described_class.first.path).to eq 'FSTN1'
  end

  it 'has a title' do
    expect(described_class.third.title).to eq described_class.third.path
  end

  describe 'find by subtypes in any order' do
    4.times do |i|
      it "can find my type by my subtypes rotated by #{i}" do
        expect(described_class
          .with(described_class.my_type.subtypes.rotate(i)).second)
          .to eq described_class.my_type
      end
    end
  end
end
