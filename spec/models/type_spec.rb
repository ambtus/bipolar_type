require 'rails_helper'

RSpec.describe Type, type: :model do

  it 'can be found by tlas in any order' do
    my_tlas = Type.my_type.problems.map(&:tla)
    4.times do |i|
      expect(Type.find_by_tlas(my_tlas.rotate(i).join)).to be Type.my_type
    end
  end

  it 'can be found by three out of four tlas' do
    4.times do |i|
      my_tlas = Type.my_type.problems.map(&:tla)
      my_tlas.delete_at(i)
      expect(Type.find_by_tlas(my_tlas.join)).to be Type.my_type
    end
  end

  it 'raises on two tlas' do
    string = Type.my_type.problems.map(&:tla)[0,2].join
    expect {Type.find_by_tlas(string)}.to raise_error RuntimeError
  end

end
