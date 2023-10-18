class TypesController < ApplicationController
  def show
    @type = Type.new params[:id]
    @title = @type.name
    render 'type'
  end

  def index
    @title = 'The 24 BipolarTypes'
    render 'types'
  end
end
