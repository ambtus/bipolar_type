# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Bipolar, type: :model do
  described_class::SYMBOLS.each_with_index do |sym, index|
    it "can find #{(index + 1).ordinalize} #{described_class.name} by #{sym}" do
      expect(described_class.find(sym)).to be described_class.all[index]
    end
  end
  it 'can find my bipolar type' do
    expect(described_class.mine.path).to eq described_class.my_path
  end

  it 'I have a sibling' do
    expect(described_class.mine.sibling).to be_a described_class
  end

  it 'which is not my bipolar type' do
    bipolar = described_class.mine
    expect(bipolar.sibling).not_to eq described_class.mine
  end

  it 'but has the same type' do
    bipolar = described_class.mine
    expect(bipolar.sibling.type).to eq described_class.mine.type
  end

  it 'I have a similar' do
    expect(described_class.mine.similar).to be_a described_class
  end

  it 'which is also not my bipolar type' do
    bipolar = described_class.mine
    expect(bipolar.similar).not_to eq described_class.mine
  end

  it 'but has the same dos' do
    bipolar = described_class.mine
    expect(bipolar.similar.dos.map(&:string).sort).to eq described_class.mine.dos.map(&:string).sort
  end

  it 'I have a different' do
    expect(described_class.mine.different).to be_a described_class
  end

  it 'which is still not my bipolar type' do
    bipolar = described_class.mine
    expect(bipolar.different).not_to eq described_class.mine
  end

  it 'but has the same donts' do
    bipolar = described_class.mine
    expect(bipolar.different.donts.map(&:string).sort).to eq described_class.mine.donts.map(&:string).sort
  end
end
