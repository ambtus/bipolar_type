class TypesController < ApplicationController
  def show
#     begin
    @type = Type.new params[:id]
    @name = @type.name
    @realms = @type.realms
    @group_by = params[:group_by] || "attitude"
#     rescue
#       redirect_to root_path and return
#     end
  end

  def index; end
end
