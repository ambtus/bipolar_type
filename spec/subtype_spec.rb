# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Subtype, type: :model do
  describe 'episodes' do
    it 'has my first depression' do
      expect(Type.my_type.subtypes.first.episode).to match 'autumn/winter depression'
    end

    it 'has my first mania' do
      expect(Type.my_type.subtypes.second.episode).to match 'summer/autumn mania'
    end

    it 'has my second mania' do
      expect(Type.my_type.subtypes.third.episode).to match 'spring/summer mania'
    end

    it 'has my second depression' do
      expect(Type.my_type.subtypes.fourth.episode).to match 'winter/spring depression'
    end
  end
end
