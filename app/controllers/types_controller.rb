class TypesController < ApplicationController

  def show
    @type = Type.find params[:id]
    render 'type'
  end

  def me
    redirect_to action: 'show', id: Type.my_path
  end
end
