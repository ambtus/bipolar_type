# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Attitude, type: :model do
  it 'has a path' do
    expect(described_class.first.path).to eq 'ip'
  end

  it 'has a title' do
    expect(described_class.third.title).to eq 'ej<br />use strength'
  end

  it 'has an html safe title' do
    expect(described_class.last.title.html_safe?).to be true
  end
end
