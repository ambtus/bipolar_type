# frozen_string_literal: true

class AttitudesController < ApplicationController
  def index
    @title = '4 Activities'
    render 'activity'
  end

  def show
    @activity = Attitude.find params[:id]
    @title = @activity.title
    render 'activity'
  end
end
