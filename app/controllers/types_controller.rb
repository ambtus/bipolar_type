class TypesController < ApplicationController
  def show
    @type = Type.new params[:id]
    @title = @type.symbol
  end

  def index; @title = 'The 24 BipolarTypes'; end
end
