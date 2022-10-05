class TypesController < ApplicationController
  def show
    @type = Type.new params[:id].scan(/./)
    @title = @type.symbol
    @class = "center"
  end

  def index; @title = 'The 16 Subtypes'; end
end
