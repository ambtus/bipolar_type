# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Realm, type: :model do
  it 'has a path' do
    expect(described_class.first.path).to eq 'F'
  end

  it 'has a title' do
    expect(described_class.third.title).to eq 'T<br />material'
  end
end
