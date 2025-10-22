# frozen_string_literal: true
class AttitudesController < ApplicationController

  def show
    @thing = Attitude.find params[:id]
    @title = @thing.title
    render 'concept'
  end
end
