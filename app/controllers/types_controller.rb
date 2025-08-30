# frozen_string_literal: true

class TypesController < ApplicationController
  def index
    string = params[:format] || ''
    @current = string.split('-')
    @free = Behavior.without(@current)
    if @free.size == 1
      redirect_to answer_path [string, Behavior.without(@current).map(&:tla).first].join('-')
    else
      @title = "BipolarTypes#{" with #{@current.and}" if @current.present?}"
      render 'types'
    end
  end

  def show
    path, set = params[:id].split('_')
    @type = Type.new path
    @current_words = params[:id]
    @next_words = @type.path + suffix(set)
    @number = set.to_i
    @all = params[:format]
    @title = @type.title
    render 'type'
  end

  def me
    redirect_to action: 'show', id: Type.my_path
  end

  private

  def suffix(set)
    return '_1' if set.blank?
    return '' if set == '5'

    "_#{set.next}"
  end
end
