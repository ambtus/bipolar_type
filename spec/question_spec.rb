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
end
