require 'rails_helper'

RSpec.describe Subtype, type: :model do

  it 'winnowed first time leaves 9' do
    expect(Subtype.without(Subtype.first.tla).count).to eq 9
  end

  it 'winnowed again leaves 4' do
    expect(Subtype.without(Subtype.first.tla + Subtype.first.next_realm.next.tla).count).to eq 4
  end

  it 'winnowed a third time leaves 1' do
    expect(Subtype.without(Subtype.first.tla + Subtype.first.next_realm.next.tla + Subtype.first.next_realm.next.next_realm.next.tla).count).to eq 1
  end

end
