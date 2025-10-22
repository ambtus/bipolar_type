# frozen_string_literal: true

class MoodsController < ApplicationController
  def show
    @mood = Mood.find params[:id]
    @title = @mood.title
    render 'mood'
  end
end
