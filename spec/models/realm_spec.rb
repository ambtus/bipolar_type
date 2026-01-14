# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Realm, type: :model do
  described_class::SYMBOLS.each_with_index do |sym, index|
    it "can find #{(index + 1).ordinalize} #{described_class.name} by #{sym}" do
      expect(described_class.send(sym)).to be described_class.all[index]
    end
  end
  it 'describes the physical, mental, and other things' do
    expect(described_class.all.map(&:realm)).to include('physical', 'mental')
  end
end
