class AttitudesController < ApplicationController

  def show
    @attitude = Attitude.find_by(params[:id])
    render 'attitude'
  end
end