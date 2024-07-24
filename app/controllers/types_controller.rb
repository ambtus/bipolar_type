class TypesController < ApplicationController
  def show
#     begin
    @type = Type.send params[:id]
#     rescue
#       redirect_to root_path and return
#     end
  end

  def index; @sort_order = params[:sort_order] || Type::ORDERS.first; end

  def me; redirect_to action: 'show', id: Type.my_path; end
end
