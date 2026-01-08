# frozen_string_literal: true

class TypesController < ApplicationController
  def show
    @type = Type.find params[:id]
    @title = @type.string
    @breadcrumbs = @type.breadcrumbs
    render @type.render
  end

  def me
    redirect_to action: 'show', id: Type.mine.path
  end
end
