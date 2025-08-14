# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Behavior, type: :model do
  describe 'without' do
    it 'starts returns all 16 on empty array' do
      expect(described_class.without([])).to eq described_class.all
    end

    it 'returns 9 on single tla' do
      expect(described_class.without([Behavior.first.tla]).count).to be 9
    end

    it 'returns 4 on two tlas' do
      expect(described_class.without(Type.my_type.tlas.sample(2)).count).to be 4
    end

    it 'returns 1 on three tlas' do
      expect(described_class.without(Type.my_type.tlas.sample(3)).count).to be 1
    end
  end
end
