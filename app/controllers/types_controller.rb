class TypesController < ApplicationController
  def show
    @type = Type.new params[:id]
    @title = @type.symbol
  end

  def my
    @type = Type.my_type
    render :show
  end

  def index; @title = 'The 24 BipolarTypes'; end
end
