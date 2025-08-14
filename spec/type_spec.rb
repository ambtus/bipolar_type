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
end
