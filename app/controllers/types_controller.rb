# frozen_string_literal: true

class TypesController < ApplicationController
  def index
    @current = params[:format] || ''
    @taken = @current.chars
    @subtypes = @current.scan(/../).collect { |s| Subtype.find(s) }
    if @current.length == 6
      redirect_to type_path Type.find_by(subtypes: @subtypes)
    else
      @title = "BipolarTypes#{" with #{@current.scan(/../).and}" if @current.present?}"
      render 'types'
    end
  end

  def show
    @type = Type.new params[:id]
    @all = params[:format]
    @title = @type.title
    @energy, @output, @strength, @intake = @type.realms
    render 'type'
  end

  def me
    redirect_to action: 'show', id: Type.my_path
  end
end
