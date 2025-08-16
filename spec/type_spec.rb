# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Type, type: :model do
  it 'has the same behaviors as other similar types' do
    my_behaviors = described_class.my_type.behaviors
    4.times do |i|
      found = described_class.new(my_behaviors.map(&:tla).rotate(i).join('•'))
      expect(found.behaviors - my_behaviors).to be_empty
    end
  end

  it 'raises on two tlas' do
    string = described_class.my_type.tlas.sample(2).join('•')
    expect { described_class.new(string) }.to raise_error RuntimeError
  end

  it 'has my tops' do
    expect(described_class.my_type.tops.first.tla).to eq 'etp'
  end

  it 'has your tops' do
    expect(described_class.your_type.tops.first.tla).to eq 'esp'
  end

  it 'has my bottoms' do
    expect(described_class.my_type.bottoms.first.tla).to eq 'ifp'
  end

  it 'has your bottoms' do
    expect(described_class.your_type.bottoms.first.tla).to eq 'inp'
  end
end
