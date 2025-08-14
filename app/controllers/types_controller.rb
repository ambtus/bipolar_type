# frozen_string_literal: true

class TypesController < ApplicationController
  def index
    @current = params[:format] || ''
    @title = title
    if @current.length == 9
      @type = Type.find_by(tlas: @current)
      redirect_to action: 'show', id: @type.path
    else
      @free = Behavior.without(@current)
      @severity = severity
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

  private

  def severity
    return 0 if @free.count == 16
    return 1 if @free.count == 9

    2
  end

  def title
    suffix = @current.blank? ? '' : " with #{params[:format].scan(/.../).sort.and}"
    @title = "BipolarTypes#{suffix}"
  end
end
