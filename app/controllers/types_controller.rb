# frozen_string_literal: true

class TypesController < ApplicationController
  def index
    string = params[:format] || ''
    @current = string.split('-')
    @free = Behavior.without(@current)
    if @free.size == 1
      redirect_to answer_path [string, Behavior.without(@current).map(&:tla).first].join('-')
    else
      @title = "BipolarTypes#{" with #{@current.and}" if @current.present?}"
      render 'types'
    end
  end

  def show
    path = params[:id]
    @type = Type.new path
    @all = params[:format]
    @title = @type.title
    render 'type'
  end

  def me
    redirect_to action: 'show', id: Type.my_path
  end
end
