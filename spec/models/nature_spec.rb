# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Nature, type: :model do
  it 'has a path' do
    expect(described_class.first.path).to eq 'FpeSTjiN'
  end

  it 'has a class title' do
    expect(described_class.title).to eq '24 Natures'
  end

  it 'has an instance link' do
    expect(described_class.first.link).to eq 'Fp•eS•Tj•iN'
  end

  it 'has an instance title' do
    expect(described_class.first.title).to eq described_class.first.link
  end

  describe 'find by subtypes in any order' do
    4.times do |i|
      it "can find my nature by my subtypes rotated by #{i}" do
        expect(described_class
          .find_by(Type.my_type.subtypes.rotate(i)))
          .to eq Type.my_type.nature
      end
    end
  end

  describe 'can be sorted' do
    it 'by p' do
      expect(described_class.sort_by('p').first.subtypes.first).to eq Subtype.Fp
    end

    it 'by e' do
      expect(described_class.sort_by('e').first.subtypes.second).to eq Subtype.eF
    end

    it 'by j' do
      expect(described_class.sort_by('j').first.subtypes.third).to eq Subtype.Fj
    end

    it 'by i' do
      expect(described_class.sort_by('i').first.subtypes.last).to eq Subtype.iF
    end
  end
end
