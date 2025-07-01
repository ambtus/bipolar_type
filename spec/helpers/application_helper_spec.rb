require 'rails_helper'

RSpec.describe ApplicationHelper, type: :helper do
  describe 'nbsp' do
    it 'is a shortcut to the html entity' do
      expect(helper.nbsp).to eq('&nbsp;')
    end

    it 'is safe' do
      expect(helper.nbsp.html_safe?).to be true
    end
  end

  describe 'ordinal' do
    it 'gives first for index 0' do
      expect(helper.ordinal(0)).to eq 'first'
    end
  end
end
