class TypesController < ApplicationController
  def show
    @type = Type.new params[:id]
    @title = @type.name
    render "type"
  end
end
