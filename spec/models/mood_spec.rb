# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Mood, type: :model do
  it 'has a path' do
    expect(described_class.first.path).to eq 'p'
  end

  it 'has a title' do
    expect(described_class.third.title).to eq 'strength'
  end

end
