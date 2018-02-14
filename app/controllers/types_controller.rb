class TypesController < ApplicationController
  def show
#     begin
    @type = Type.new params[:id]
    @name = @type.name
    @subtypes = @type.subtypes
#     rescue
#       redirect_to root_path and return
#     end
  end
end
