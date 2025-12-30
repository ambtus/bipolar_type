# frozen_string_literal: true

class TypesController < ApplicationController
  def show
    @number = 4
    @type = Type.find params[:id]
    @title = "#{@type.title} Type"
    @manic_realm = @type.realms.third
    render 'type'
  end
end
