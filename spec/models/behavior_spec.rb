# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Behavior, type: :model do
  described_class::SYMBOLS.each_with_index do |sym, index|
    it "can find #{(index + 1).ordinalize} #{described_class.name} by #{sym}" do
      expect(described_class.send(sym)).to be described_class.all[index]
    end
  end
  %w[iSp eFp eNj iTp].each do |sym|
    it "#{sym} has a generic description" do
      expect(described_class.send(sym).generic).to be_an String
    end

    it "#{sym} has a focus" do
      expect(described_class.send(sym).focus).to be_an String
    end

    it "#{sym} has examples" do
      expect(described_class.send(sym).examples).to be_an Array
    end

    it "#{sym} has a green title" do
      expect(described_class.send(sym).title(green: true)).to match "#{sym}: do "
    end

    it "#{sym} has a red title" do
      expect(described_class.send(sym).title(green: false)).to match "#{sym}: don’t "
    end
  end
end
