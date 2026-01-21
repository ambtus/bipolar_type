# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Mood, type: :model do
  described_class::SYMBOLS.each_with_index do |sym, index|
    it "can find #{(index + 1).ordinalize} #{described_class.name} by #{sym}" do
      expect(described_class.send(sym)).to be described_class.all[index]
    end
  end
  it "i has the right sibling_actions" do
    expect(described_class.i.sibling_actions).to eq [Action.ij, Action.ip]
  end
  it "p has the right sibling_actions" do
    expect(described_class.p.sibling_actions).to eq [Action.ip, Action.ep]
  end
  it "e has the right sibling_actions" do
    expect(described_class.e.sibling_actions).to eq [Action.ep, Action.ej]
  end
  it "j has the right sibling_actions" do
    expect(described_class.j.sibling_actions).to eq [Action.ej, Action.ij]
  end
end
