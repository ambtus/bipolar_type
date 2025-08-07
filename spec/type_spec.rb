# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Type, type: :model do
  it 'can be found by tlas in any order' do
    my_tlas = described_class.my_type.subtypes.map(&:tla)
    4.times do |i|
      expect(described_class.find_by(tlas: my_tlas.rotate(i).join)).to be described_class.my_type
    end
  end

  it 'can be found by three out of four tlas' do
    4.times do |i|
      my_tlas = described_class.my_type.subtypes.map(&:tla)
      my_tlas.delete_at(i)
      expect(described_class.find_by(tlas: my_tlas.join)).to be described_class.my_type
    end
  end

  it 'raises on two tlas' do
    string = described_class.my_type.subtypes.map(&:tla)[0, 2].join
    expect { described_class.find_by(tlas: string) }.to raise_error RuntimeError
  end
end
