# frozen_string_literal: true

class TypesController < ApplicationController
  def index
    @answers = params[:format] || ''
    @greens = @answers.empty? ? [] : @answers.scan(/.../).collect { |x| Behavior.find(x) }.sort
    @chosen = @greens.map(&:similars).flatten

    @title = "#{(@greens.length + 1).ordinalize} question" + (@answers.blank? ? '' : " for #{@answers}")

    if @answers.length == 12
      type = Type.find_by_greens(@greens)
      redirect_to action: 'show', id: type.path
    end
  end

  def show
    @type = Type.find params[:id]
    @title = @type.title
    @realms = @type.realms
  end

  def me
    redirect_to action: 'show', id: Type.mine.path
  end
end
