# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Subtype, type: :model do
  describe 'episodes' do
    it 'has my mild depression' do
      expect(Type.my_type.subtypes.first.episode).to match Regexp.new('mild .* depression')
    end

    it 'has my mild mania' do
      expect(Type.my_type.subtypes.second.episode).to match Regexp.new('relatively mild .* mania')
    end

    it 'has my severe mania' do
      expect(Type.my_type.subtypes.third.episode).to match Regexp.new('relatively severe .* mania')
    end

    it 'has my severe depression' do
      expect(Type.my_type.subtypes.fourth.episode).to match Regexp.new('severe .* depression')
    end
  end
end
