class StartController < ApplicationController
  def cycle
    @title = 'The Cycle'
    @sixteen = Realm.generic.subtypes
    render 'cycle'
  end
end
