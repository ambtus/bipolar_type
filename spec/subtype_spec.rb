# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Subtype, type: :model do
  describe 'episodes' do
    it 'has my mild depression' do
      expect(Type.my_type.subtypes.first.episode).to match 'autumn/winter depression'
    end

    it 'has my mild mania' do
      expect(Type.my_type.subtypes.second.episode).to match 'spring/summer mania'
    end

    it 'has my severe mania' do
      expect(Type.my_type.subtypes.third.episode).to match 'summer/autumn mania'
    end

    it 'has my severe depression' do
      expect(Type.my_type.subtypes.fourth.episode).to match 'winter/spring depression'
    end
  end
end
