# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Behavior, type: :model do
  it 'has a path' do
    expect(described_class.first.path).to eq 'iFp'
  end

  it 'has a title' do
    expect(described_class.third.title).to eq 'eFj<br />preach'
  end
end
