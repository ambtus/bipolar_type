# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Subtype, type: :model do
  it 'has a path' do
    expect(described_class.first.path).to eq 'Sp'
  end

  it 'has a title' do
    expect(described_class.third.title).to eq 'Sj: physical strength'
  end
end
