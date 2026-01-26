# frozen_string_literal: true

class TypesController < ApplicationController
  def index
    @answers = params[:format] || ''
    @subtypes = @answers.empty? ? [] : @answers.scan(/../).collect { |x| Subtype.find(x) }.sort
    @title = "#{(@subtypes.length + 1).ordinalize} question" + (@answers.blank? ? '' : " for #{@answers}")
    render 'skew' and return if @answers.length == 8
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
