# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Subtype, type: :model do
  it 'raises on bad string' do
    expect { described_class.new('Fx').how }.to raise_error(RuntimeError)
  end
end
