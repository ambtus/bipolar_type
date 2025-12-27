# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Nature, type: :model do
  described_class::SYMBOLS.each_with_index do |sym, index|
    it "can find #{(index + 1).ordinalize} #{described_class.name} by #{sym}" do
      expect(described_class.find(sym)).to be described_class.all[index]
    end

    it "#{sym} has two types" do
      expect(described_class.all[index].types.count).to be 2
    end
  end
end
