# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Type, type: :model do
  described_class::SYMBOLS.each_with_index do |sym, index|
    it "can find #{(index + 1).ordinalize} #{described_class.name} by #{sym}" do
      expect(described_class.find(sym)).to be described_class.all[index]
    end
  end
  it 'can find my bipolar type' do
    expect(described_class.mine.path).to eq described_class.my_path
  end

end
