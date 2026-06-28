# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Behavior, type: :model do
  describe 'without' do
    it 'starts returns all 16 on empty array' do
      expect(described_class.without([])).to eq described_class.all
    end
  end
end
