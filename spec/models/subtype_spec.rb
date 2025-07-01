# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Subtype, type: :model do
  it 'winnowed first time leaves 9' do
    expect(described_class.without(described_class.first.tla).count).to eq 9
  end

  it 'winnowed again leaves 4' do
    two = described_class.first.tla + described_class.first.next_realm.next.tla
    expect(described_class.without(two).count).to eq 4
  end

  it 'winnowed a third time leaves 1' do
    two = described_class.first.tla + described_class.first.next_realm.next.tla
    three = two + described_class.first.next_realm.next.next_realm.next.tla
    expect(described_class.without(three).count).to eq 1
  end
end
