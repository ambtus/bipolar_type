# frozen_string_literal: true

class TypesController < ApplicationController
  def index
    string = params[:format] || ''
    @current = string
    @taken = @current.chars
    @subtypes = @current.scan(/../).collect{|s| Subtype.find(s)}
    if @current.length == 6
      type = Type.find_by(subtypes: @subtypes)
      redirect_to type_path(type.path)
    else
      @title = "BipolarTypes#{" with #{@current.scan(/../).and}" if @current.present?}"
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
