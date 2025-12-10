# frozen_string_literal: true

class MoodsController < ApplicationController
  def index
    @title = Mood.title
    render 'moods'
  end

  def show
    @concept = Mood.find params[:id]
    @title = @concept.title
    render 'concept'
  end
end
