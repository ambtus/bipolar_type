# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Realm, type: :model do
  it 'has a path' do
    expect(described_class.first.path).to eq 'F'
  end

  it 'has a title' do
    expect(described_class.third.title).to start_with 'T: financial'
  end

  it 'has behaviors' do
    expect(described_class.second.behaviors).to include Behavior.iSp
  end

  it 'has subtypes' do
    expect(described_class.fourth.subtypes).to include Subtype.Nj
  end

  it 'can add an action' do
    expect(described_class.F + Action.ej).to eq Behavior.eFj
  end

  it 'can add a mood' do
    expect(described_class.S + Mood.i).to eq Subtype.iS
  end
end
