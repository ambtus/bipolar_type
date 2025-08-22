# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Subtype, type: :model do
  describe 'episodes' do
    it 'has my first depression' do
      expect(Type.my_type.subtypes.first.episode).to eq "4th: autumn/winter spiritual depression"
    end
    it 'has my second mania' do
      expect(Type.my_type.subtypes.second.episode).to eq "3rd: spring/summer mental mania"
    end
    it 'has my second mania' do
      expect(Type.my_type.subtypes.third.episode).to eq "2nd: summer/autumn material mania"
    end
    it 'has my second mania' do
      expect(Type.my_type.subtypes.fourth.episode).to eq "1st: winter/spring physical depression"
    end
  end
end
