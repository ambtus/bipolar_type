# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Subtype, type: :model do
  it 'has a path' do
    expect(described_class.Sp.path).to eq 'Sp'
  end

  it 'has a title' do
    expect(described_class.Sj.title).to start_with 'Sj: '
  end
end
