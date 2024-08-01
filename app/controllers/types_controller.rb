class TypesController < ApplicationController
  def show
    @type = Type.send params[:id]
    @title = "The #{@type.name} Cycle"
    @sixteen =  @type.sixteen
    render 'cycle'
  end

  def me; redirect_to action: 'show', id: Type.my_path; end
end
