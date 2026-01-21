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

  it "has the right behaviors for iS" do
    expect(described_class.iS.behaviors).to eq [Behavior.iSj, Behavior.iSp]
  end
  it "has the right behaviors for Fp" do
    expect(described_class.Fp.behaviors).to eq [Behavior.iFp, Behavior.eFp]
  end
  it "has the right behaviors for eT" do
    expect(described_class.eT.behaviors).to eq [Behavior.eTp, Behavior.eTj]
  end
  it "has the right behaviors for Nj" do
    expect(described_class.Nj.behaviors).to eq [Behavior.eNj, Behavior.iNj]
  end
end
