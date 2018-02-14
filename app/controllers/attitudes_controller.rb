class AttitudesController < ApplicationController
  def index; @attitudes = Attitude.all; end
  def show
    @attitude = Attitude.send params[:id]
    @name = @attitude.problem
    @subtypes = @attitude.subtypes
  end
end
