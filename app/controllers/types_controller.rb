# frozen_string_literal: true

class TypesController < ApplicationController
  def show
    @number = 5
    @type = Type.find params[:id]
    @nature = @type.nature
    @title = @type.title
    render 'type'
  end

  def me
    redirect_to action: 'show', id: Type.my_path
  end
end
