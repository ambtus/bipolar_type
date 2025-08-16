# frozen_string_literal: true

class TypesController < ApplicationController
  def index
    string = params[:format] || ''
    @current = string.split('•')
    @title = "BipolarTypes#{" with #{@current.and}" if @current.present?}"
    @free = Behavior.without(@current)
    if @free.length == 1
      path = [string, @free.first.tla].join('•')
      redirect_to action: 'show', id: path
    else
      render 'types'
    end
  end

  def show
    string = params[:format] || ''
    @show = string.blank? ? [] : string.scan(/../)
    @type = Type.new params[:id]
    @title = @type.title
    render 'type'
  end

  def me
    redirect_to action: 'show', id: Type.my_path
  end
end
