class AttitudesController < ApplicationController
  def index; @attitudes = Attitude.all; end
  def show
    @attitude = Attitude.send params[:id]
    @name = @attitude.name
    @subtypes = @attitude.subtypes
  end
end
