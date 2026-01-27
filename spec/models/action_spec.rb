# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Action, type: :model do
  described_class::SYMBOLS.each_with_index do |sym, index|
    it "can find #{(index + 1).ordinalize} #{described_class.name} by #{sym}" do
      expect(described_class.send(sym)).to be described_class.all[index]
    end
  end

  it 'has a flip' do
    expect(described_class.ip.flip).to eq described_class.ep
  end
  it 'has a flop' do
    expect(described_class.ip.flop).to eq described_class.ij
  end
  it 'has an opposite' do
    expect(described_class.ip.opposite).to eq described_class.ej
  end
end
