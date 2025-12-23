# frozen_string_literal: true

class TypesController < ApplicationController
  def index
    @current = params[:format] || ''
    @subtypes = @current.scan(/../).collect { |s| Subtype.find(s) }
    @title = Type.title(@subtypes)
    if @current.length >= 6
      @type = Type.with(@subtypes).first
      redirect_to nature_path @type.nature.path
    else
      render 'types'
    end
  end

  def show
    @type = Type.find params[:id]
    if @type.nil?
      redirect_to types_path, alert: "“#{params[:id]}“ is not a valid type path"

    else
      @title = @type.title
      render 'type'
    end
  end

  def me
    redirect_to action: 'show', id: Type.my_path
  end
end
