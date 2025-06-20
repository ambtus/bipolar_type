require 'rails_helper'

RSpec.describe Type, type: :model do

  it 'can be found by tlas in any order' do
    expect(Type.find_by_tlas('UFSGPEUEEGMS')).to be Type.my_type
    expect(Type.find_by_tlas('UEEUFSGMSGPE')).to be Type.my_type
    expect(Type.find_by_tlas('UFSGMSGPEUEE')).to be Type.my_type
  end


end
