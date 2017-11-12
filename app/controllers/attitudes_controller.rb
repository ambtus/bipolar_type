class AttitudesController < ApplicationController
  def index; end
  def show
    @attitude = Attitude.send params[:id]
    @name = @attitude.name
    @subtypes = @attitude.subtypes
  end
end
