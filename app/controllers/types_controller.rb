class TypesController < ApplicationController
  def show
    @type = Type.new params[:id]
    render "type"
  end
end
