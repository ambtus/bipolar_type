# frozen_string_literal: true

class WordsController < ApplicationController
  def index
    @title = '16 Subtypes'
    max_cookie_length = cookies.to_h.values.map(&:length).max || 0
    max_size = [max_cookie_length, 80].min
    min_size = 15
    @size = [min_size, max_size].max
    render 'words'
  end
end
