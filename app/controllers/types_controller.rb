# frozen_string_literal: true

class TypesController < ApplicationController
  def index
    @current = params[:format] || ''
    suffix = @current.blank? ? '' : " with #{params[:format].scan(/.../).sort.and}"
    @title = "BipolarTypes#{suffix}"
    if @current.length == 9
      @type = Type.find_by(tlas: @current)
      redirect_to action: 'show', id: @type.path
    else
      @free = Subtype.without(@current)
      render 'types'
    end
  end

  def show
    @type = Type.find params[:id]
    @title = @type.title
    render 'type'
  end

  def me
    redirect_to action: 'show', id: Type.my_path
  end
end
