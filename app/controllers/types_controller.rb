# frozen_string_literal: true

class TypesController < ApplicationController
  def index
    @answers = params[:format] || ''
    @chosen = @answers.empty? ? [] : @answers.scan(/../).collect { |x| [Realm.find(x.first), Compass.find(x.second)] }

    @title = "#{(@chosen.length + 1).ordinalize} question" + (@answers.blank? ? '' : " for #{@answers}")

    if @chosen.length == 4
      type = Type.find_by_chosen(@chosen)
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
