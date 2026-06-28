# frozen_string_literal: true

class TypesController < ApplicationController
  def index
    @string = params[:format] || ''
    @chosen = @string.chars.collect{|s| Attitude.find(s)}
    @realm = Realm.linear[@chosen.length]
    if @chosen.length == 4
      redirect_to type_path @string
    else
      @title = "BipolarTypes#{" with #{@chosen.and}" if @chosen.present?}"
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
