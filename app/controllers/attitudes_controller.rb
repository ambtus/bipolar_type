class AttitudesController < ApplicationController
  def show
    @attitude = Attitude.find(params[:id])
    render 'theory'
  end
end
