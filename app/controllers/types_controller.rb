class TypesController < ApplicationController
  def show
    @type = Type.new params[:id].scan(/./)
    @title = @type.symbol
    @class = "center"
    @t = @type.first_realm
    @f = @type.second_realm
    @n = @type.third_realm
    @s = @type.fourth_realm
  end

  def index; @title = 'The 24 BipolarTypes'; @class = "index"; @index = true ; end
end
