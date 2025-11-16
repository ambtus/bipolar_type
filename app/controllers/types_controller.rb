# frozen_string_literal: true

class TypesController < ApplicationController
  def index
    @current = params[:format] || ''
    @subtypes = @current.scan(/../).collect { |s| Subtype.find(s) }
    @title = Type.title(@subtypes)
    if @current.length >= 6
      @siblings = Type.with(@subtypes)
      render 'bipolar'
    else
      render 'types'
    end
  end

  def show
    @type = Type.new params[:id]
    @title = @type.title
    render 'type'
  end

  def me
    redirect_to action: 'show', id: Type.my_path
  end
end
