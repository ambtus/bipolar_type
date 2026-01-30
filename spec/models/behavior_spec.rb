# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Behavior, type: :model do
  described_class::SYMBOLS.each_with_index do |sym, index|
    it "can find #{(index + 1).ordinalize} #{described_class.name} by #{sym}" do
      expect(described_class.send(sym)).to be described_class.all[index]
    end
  end

  it 'has a flip' do
    expect(described_class.iSj.flip).to eq described_class.eSj
  end

  it 'has a flop' do
    expect(described_class.iSj.flop).to eq described_class.iSp
  end

  it 'has an opposite' do
    expect(described_class.iSj.opposite).to eq described_class.eSp
  end

  it 'has siblings' do
    expect(described_class.iSj.siblings).to eq [described_class.eSj, described_class.iSp]
  end
end
