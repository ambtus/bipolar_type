# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Realm, type: :model do
  described_class::SYMBOLS.each_with_index do |sym, index|
    it "can find #{(index + 1).ordinalize} #{described_class.name} by #{sym}" do
      expect(described_class.send(sym)).to be described_class.all[index]
    end
  end
  it 'describes the physical, mental, and other things' do
    expect(described_class.all.map(&:generic)).to include('physical', 'mental')
  end

  it 'describes people, places, tools, and ideas' do
    expect(described_class.pp_order.map(&:externals)).to eq %w[people places tools ideas]
  end

  it 'describes the body, mind, and other things' do
    expect(described_class.all.map(&:internal)).to include('body', 'mind')
  end
end
