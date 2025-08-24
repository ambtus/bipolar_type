# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'questions', type: :request do
  it 'does not guess' do
    post '/questions', params: { q: { '1' => 'enj', '2' => 'ifp' } }
    follow_redirect!
    expect(response.body).to match('The questionaire was not able to determine your BipolarType.')
  end

  it 'does derive from first three found' do
    post '/questions', params: {"q"=>{"0"=>"inj", "1"=>"isj", "2"=>"efp", "3"=>"ifj", "4"=>"inp", "5"=>"ifj", "6"=>"ifp", "7"=>"etp", "8"=>"enj", "9"=>"enj"}, "commit"=>"Analyze"}
    follow_redirect!
    expect(response.body).to match('enj-ifj-etp-isp')
  end

  it 'requires a minimum of three non-siblings' do
    post '/questions', params: { q: { '1' => 'enj', '2' => 'ifp', '3' => 'isj' } }
    follow_redirect!
    expect(response.body).not_to match('The questionaire was not able to determine your BipolarType.')
  end

  it 'does not guess if siblings' do
    post '/questions', params: { q: { '1' => 'enj', '2' => 'ifp', '3' => 'ifj' } }
    follow_redirect!
    expect(response.body).to match('The questionaire was not able to determine your BipolarType.')
  end

  it 'lets you try with a found behavior' do
    post '/questions', params: { q: { '1' => 'enj' } }
    follow_redirect!
    expect(response.body).to match('with the function:')
  end

  it 'lets you try with found behaviors' do
    post '/questions', params: { q: { '1' => 'enj', '2' => 'ifp' } }
    follow_redirect!
    expect(response.body).to match('with one of the functions:')
  end

  it 'lets you try with other questions even if it finds something' do
    post '/questions', params: { q: { '1' => 'enj', '2' => 'ifp', '3' => 'isj' } }
    follow_redirect!
    expect(response.body).to match('alternate')
  end

  it 'should not permit siblings' do
     post '/questions', params: {"q"=>{"0"=>"inj", "1"=>"inp", "2"=>"inp", "3"=>"esj", "4"=>"itj", "5"=>"itp", "6"=>"inj", "7"=>"isp", "8"=>"efp", "9"=>"ifj", "10"=>"enj", "11"=>"efj", "12"=>"enj", "13"=>"enj", "14"=>"isp", "15"=>"ifj", "16"=>"enj", "17"=>"efp", "18"=>"inp", "19"=>"ifj"}, "commit"=>"Analyze"}
     follow_redirect!
     expect(response.body).to match('enj-ifj-isp-etp')
  end

end
