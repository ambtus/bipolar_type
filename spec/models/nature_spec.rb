# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Nature, type: :model do
  it 'has a path' do
    expect(described_class.first.path).to eq 'iFSpeTNj'
  end

  it 'has a class title' do
    expect(described_class.title).to eq '24 Natures'
  end

  it 'has an instance link' do
    expect(described_class.first.link).to eq 'iF, Sp, eT, and Nj'
  end

  it 'has an instance title' do
    expect(described_class.first.title).to eq 'iF, Sp, eT, and Nj'
  end

  describe 'can be sorted' do
    it 'by i' do
      expect(described_class.min_by('i').subtypes.first).to eq Subtype.iF
    end

    it 'by p' do
      expect(described_class.min_by('p').subtypes.second).to eq Subtype.Fp
    end

    it 'by e' do
      expect(described_class.min_by('e').subtypes.third).to eq Subtype.eF
    end

    it 'by j' do
      expect(described_class.min_by('j').subtypes.fourth).to eq Subtype.Fj
    end
  end
end
