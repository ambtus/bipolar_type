# frozen_string_literal: true

class TypesController < ApplicationController
  def index
    @string = params[:format] || ''
    @chosen = @string.split('-').collect{|s| Behavior.find(s)}
    @free_realms = Realm.without(@chosen.map(&:realm))
    if @free_realms.size == 0
      redirect_to type_path @string
    else
      @title = "BipolarTypes#{" with #{@current.and}" if @current.present?}"
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
