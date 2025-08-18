# frozen_string_literal: true

class TypesController < ApplicationController
  def index
    string = params[:format] || ''
    @current = string.split('•')
    @free = Behavior.without(@current)
    if @free.empty?
      redirect_to answer_path string
    else
      @title = "BipolarTypes#{" with #{@current.and}" if @current.present?}"
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
