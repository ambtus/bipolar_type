# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'questions', type: :request do
  it 'does not guess' do
    post '/questions', params: { q: { '1' => 'enj', '2' => 'ifp' } }
    follow_redirect!
    expect(response.body).to match('The questionaire was not able to determine your BipolarType.')
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
    expect(response.body).to match('function:')
  end

  it 'lets you try with found behaviors' do
    post '/questions', params: { q: { '1' => 'enj', '2' => 'ifp' } }
    follow_redirect!
    expect(response.body).to match('functions:')
  end

  it 'puts found subtypes in title' do
    post '/questions', params: { q: { '1' => 'enj', '2' => 'ifp', '3' => 'ifp', '4' => 'inp' } }
    follow_redirect!
    expect(response.body).to match('<title>BipolarType: Answer: ifp-enj</title>')
  end

  it 'does derive from first three found' do
    post '/questions',
params: { 'q' => { '1' => 'enj', '3' => 'ifj', '5' => 'ifj', '7' => 'etp', '8' => 'enj', '9' => 'enj' } }
    follow_redirect!
    expect(response.body).to match('enj-ifj-etp-isp')
  end

  it 'does not permit siblings' do
    post '/questions', params: { 'q' => { '18' => 'inp', '1' => 'inp', '2' => 'inp',
                   '10' => 'enj', '12' => 'enj', '13' => 'enj', '16' => 'enj',
                   '8' => 'efp', '17' => 'efp', '9' => 'ifj', '15' => 'ifj', '19' => 'ifj' } }
    follow_redirect!
    expect(response.body).to match('<title>BipolarType: Answer: enj-ifj</title>')
  end
end
