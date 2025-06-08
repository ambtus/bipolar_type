class TypesController < ApplicationController

  def show
    @type = Type.find_by params[:id]
    @bl=@type.realms.first
    @tl=@type.realms.second
    @tr=@type.realms.third
    @br=@type.realms.fourth
    render 'type'
  end

  def me
    redirect_to action: 'show', id: Type.my_path
  end
end
