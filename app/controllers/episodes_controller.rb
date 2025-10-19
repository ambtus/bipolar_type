# frozen_string_literal: true

class EpisodesController < ApplicationController
  def index
    @title = '16 Episodes'
    render 'episodes'
  end

  def show
    @mood = Mood.find params[:id]
    @title = @mood.title
    render 'episode'
  end
end
