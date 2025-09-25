# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Realm, type: :model do
  it 'has behaviors' do
    expect(described_class.first + Attitude.first).to be Behavior.first
  end

  it 'has subtypes' do
    expect(described_class.first + Mood.first).to be Subtype.first
  end

  it 'raises on bad addition' do
    expect { described_class.first + described_class.second }.to raise_error(RuntimeError)
  end
end
