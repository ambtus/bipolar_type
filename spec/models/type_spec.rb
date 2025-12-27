# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Type, type: :model do
  described_class::SYMBOLS.each_with_index do |sym, index|
    it "can find #{(index + 1).ordinalize} #{described_class.name} by #{sym}" do
      expect(described_class.find(sym)).to be described_class.all[index]
    end
  end
  it 'can find my type' do
    expect(described_class.my_type.path).to eq described_class.my_path
  end

  it 'I have a sibling' do
    expect(described_class.my_type.sibling).to be_a described_class
  end

  it 'which is not my type' do
    type = described_class.my_type
    expect(type.sibling).not_to eq described_class.my_type
  end

  it 'but has the same nature' do
    type = described_class.my_type
    expect(type.sibling.nature).to eq described_class.my_type.nature
  end

  it 'I have a similar' do
    expect(described_class.my_type.similar).to be_a described_class
  end

  it 'which is also not my type' do
    type = described_class.my_type
    expect(type.similar).not_to eq described_class.my_type
  end

  it 'but has the same dos' do
    type = described_class.my_type
    expect(type.similar.dos.map(&:string).sort).to eq described_class.my_type.dos.map(&:string).sort
  end

  it 'I have a different' do
    expect(described_class.my_type.different).to be_a described_class
  end

  it 'which is still not my type' do
    type = described_class.my_type
    expect(type.different).not_to eq described_class.my_type
  end

  it 'but has the same donts' do
    type = described_class.my_type
    expect(type.different.donts.map(&:string).sort).to eq described_class.my_type.donts.map(&:string).sort
  end
end
