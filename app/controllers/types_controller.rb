class TypesController < ApplicationController

  def index
    @sort_index = (params[:sort] || 3).to_i
    @types = Type.sort_by(@sort_index)
    render 'types'
  end

  def show
    @type = Type.find params[:id]
    render 'type'
  end

  def me
    redirect_to action: 'show', id: Type.my_path
  end
end
