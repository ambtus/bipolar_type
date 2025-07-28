# frozen_string_literal: true

class TypesController < ApplicationController
  def index
    @title = '24 BipolarTypes'
    render 'types'
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
