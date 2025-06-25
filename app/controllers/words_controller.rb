class WordsController < ApplicationController

  def index
    @title = 'Words'
    max_cookie_length = cookies.to_h.values.map(&:length).max || 0
    max_size = max_cookie_length > 80 ? 80 : max_cookie_length
    min_size = 15
    @size = [min_size, max_size].max
    render 'words'
  end

end
