class EnergiesController < ApplicationController
  def index; end

  def show
    @energy = Energy.send params[:id]
    @name = @energy.name
    @subtypes = @energy.subtypes
  end
end
