class TypesController < ApplicationController
  def show
    @type = Type.find params[:id]
    @title = "The #{@type.name} BipolarType"
    if params[:commit] == 'Use Examples'
      Behavior.each {|b| cookies.delete(b.mbti)}
      set_cookies
      redirect_to type_path(@type.path) and return
    end
    render 'type'
  end

  def me; redirect_to action: 'show', id: Type.my_path; end
end
