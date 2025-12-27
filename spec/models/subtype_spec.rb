# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Subtype, type: :model do
  described_class::SYMBOLS.each_with_index do |sym, index|
    it "can find #{(index + 1).ordinalize} #{described_class.name} by #{sym}" do
      expect(described_class.find(sym)).to be described_class.all[index]
    end

    it "#{sym} has two behaviors" do
      expect(described_class.all[index].behaviors.count).to be 2
    end
  end
end
