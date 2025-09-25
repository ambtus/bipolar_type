# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Type, type: :model do
  describe 'find by subtypes in any order' do
    4.times do |i|
      it "can find my types by my subtypes rotated by #{i}" do
        expect(described_class.find_by(subtypes: described_class.my_type.subtypes.rotate(i)[0,
3])).to be described_class.my_type
      end
    end
  end
end
