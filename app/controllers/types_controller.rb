class TypesController < ApplicationController
  def index
    @qi = Quadrant.linear.map(&:mbti).index(params[:sort]) || 3
    @types = Type.sort_by(@qi)
    if params[:commit] == 'Hide'
      hide
      redirect_to types_path and return
    end
  end

  def show
    @type = Type.find params[:id].to_i
    @title = "The #{@type.name} BipolarType"
    if params[:commit] == 'Hide'
      hide
      redirect_to type_path(@type.path) and return
    end
    render 'type'
  end

  def me; redirect_to action: 'show', id: Type.my_path; end
end
