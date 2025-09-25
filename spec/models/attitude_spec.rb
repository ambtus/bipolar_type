# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Attitude, type: :model do
  it 'describes an at time' do
    expect(described_class.second.time).to eq 'at midday'
  end

  it 'describes an in time' do
    expect(described_class.first.time).to eq 'in the morning'
  end
end
