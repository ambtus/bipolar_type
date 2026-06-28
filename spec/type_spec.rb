# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Type, type: :model do
  it 'has my physical attitude' do
    expect(described_class.my_type.attitudes.first.string).to eq 'o'
  end

 it 'has my mental attitude' do
    expect(described_class.my_type.attitudes.second.string).to eq 'f'
  end

end
