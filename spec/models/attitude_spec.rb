# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Attitude, type: :model do
  it 'has a path' do
    expect(described_class.first.path).to eq 'ip'
  end

  it 'has a title' do
    expect(described_class.third.title).to start_with 'ej: '
  end
end
