class AttitudesController < ApplicationController
  def index; @title = 'The Four Attitudes'; end
  def show
    @attitude = Attitude.send params[:id]
    @title = @attitude.name
    @subtypes = @attitude.subtypes
  end
end
