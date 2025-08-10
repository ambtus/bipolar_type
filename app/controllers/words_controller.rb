# frozen_string_literal: true

class WordsController < ApplicationController
  def index
    @title = '16 Behaviors'
    max_cookie_length = cookies.to_h.values.map(&:length).max || 0
    max_size = [max_cookie_length, 80].min
    min_size = 15
    @size = [min_size, max_size].max
    render 'words'
  end

  def create
    if params[:reset]
      Rails.logger.debug { 'clearing cookies' }
      cookies.clear
      redirect_to words_path
    else
      Rails.logger.debug { "anchor: #{@added}" }
      redirect_to words_path + "##{@added}"
    end
  end
end
