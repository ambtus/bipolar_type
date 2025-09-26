# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Subtype, type: :model do
  it 'has a link' do
    expect(described_class.first.link).to be_present
  end
end
