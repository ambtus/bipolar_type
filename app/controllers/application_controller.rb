# frozen_string_literal: true

class ApplicationController < ActionController::Base
  def home = (@title = 'Introduction')

  def depression
    (@title = 'Morning Depression'
     @number = 1)
  end

  def insomnia
    @title = 'Evening Insomnia'
    @depression = Realm.find params[:format]
    @number = 2
  end

  def mania
    @number = 3
    @title = 'Daytime Mania'
    @depression, @insomnia = params[:format].chars.map { |x| Realm.find x }
    @possibles = Realm.all - [@depression, @insomnia]
    @first = [@depression, *@possibles.reverse, @insomnia].join
    @second = [@depression, *@possibles, @insomnia].join
  end
end
