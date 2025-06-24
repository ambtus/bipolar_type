require 'rails_helper'

RSpec.describe Type, type: :model do

  it 'can be found by tlas in any order' do
    expect(Type.find_by_tlas('UFSGPEUEE')).to be Type.my_type
    expect(Type.find_by_tlas('UFSUEEGPE')).to be Type.my_type
    expect(Type.find_by_tlas('GPEUFSUEE')).to be Type.my_type
  end


end
