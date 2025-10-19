# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Type, type: :model do
  describe 'find by subtypes in any order' do
    4.times do |i|
      it "can find my types by my subtypes rotated by #{i}" do
        expect(described_class.find_by(subtypes: described_class.my_type.subtypes.rotate(i)[0,
3])).to be described_class.my_type
      end
    end
  end

  it 'examples use all sixteen subtypes' do
    subtypes = %w[my your next other].collect{|x| Type.new(Type.send(x + '_path')).subtypes}.flatten
    expect(subtypes.uniq.count).to be 16
  end
  it 'subtypes cannot have the same realm' do
    expect { Type.new(Realm.first.subtypes.map(&:string).join('•')) }.to raise_error RuntimeError
  end
  it 'subtypes cannot have the same activity' do
    expect { Type.new(Activity.first.subtypes.map(&:string).join('•')) }.to raise_error RuntimeError
  end


end
