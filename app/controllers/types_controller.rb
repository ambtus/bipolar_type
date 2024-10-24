class TypesController < ApplicationController
  def index
    @sort_index = params[:sort].to_i || 0
    @types = Type.sort_by(@sort_index)
    render 'types'
  end

  def show
    @type = Type.find params[:id]
    cookies[:hide] = params[:hide]
    render 'type'
  end

  def me
    redirect_to action: 'show', id: Type.my_path
  end
end
