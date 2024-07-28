class StartController < ApplicationController
  def cycle
    @title = 'The Bipolar Cycle'
    @sixteen = Realm.g.subtypes.collect{|s| Array.new(4,s)}.flatten
    render 'cycle'
  end
end
