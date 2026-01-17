# frozen_string_literal: true

class TypesController < ApplicationController
  def index
    @answers = params[:format] || ''
    index = @answers.length
    ordinal = (index + 1).ordinalize
    @mood = Mood.all[index]
    @title = "#{ordinal} question" + (@answers.blank? ? '' : " for #{@answers}")
    @realms = index.zero? ? [] : @answers.chars.collect{|x| Realm.find(x)}
    render 'skew' and return if index == 4
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
