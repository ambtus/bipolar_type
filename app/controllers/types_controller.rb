# frozen_string_literal: true

class TypesController < ApplicationController
  def index
    @current = params[:format] || ''
    @taken = @current.chars
    @subtypes = @current.scan(/../).collect { |s| Subtype.find(s) }
    @title = "BipolarTypes#{" with #{@current.scan(/../).and}" if @current.present?}"
    if @current.length == 6
      @bp1 = Type.bp1(@subtypes)
      @bp2 = Type.bp2(@subtypes)
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
