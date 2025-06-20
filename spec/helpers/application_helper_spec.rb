require 'rails_helper'

RSpec.describe ApplicationHelper, type: :helper do
  describe "nbsp" do
    it "is a shortcut to the html entity" do
      expect(helper.nbsp).to eq('&nbsp;')
    end

    it 'is safe' do
      expect(helper.nbsp.html_safe?).to be true
    end
  end

  describe "circle" do
    it "is a shortcut to the html entity" do
      expect(helper.circle).to eq('&orarr;')
    end

    it 'is safe' do
      expect(helper.circle.html_safe?).to be true
    end
  end
end
