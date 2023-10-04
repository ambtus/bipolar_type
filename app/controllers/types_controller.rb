class TypesController < ApplicationController
  def show
    @type = Type.new params[:id]
    @avian = @type.avian
    render "type"
  end
end
