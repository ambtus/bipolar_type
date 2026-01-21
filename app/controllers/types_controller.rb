# frozen_string_literal: true

class TypesController < ApplicationController
  def index
    @answers = params[:format] || ''
    @title = "#{(@answers.length + 1).ordinalize} question" + (@answers.blank? ? '' : " for #{@answers}")
    @realms = @answers.empty? ? [] : @answers.chars.collect { |x| Realm.find(x) }
    render 'skew' and return if @answers.length == 4
  end

  def show
    @type = Type.find params[:id]
    @title = @type.string
    @realms = @type.realms
  end

  def me
    redirect_to action: 'show', id: Type.mine.path
  end
end
