class StartController < ApplicationController
  def cycle
    @title = 'The Cycle'
    @sixteen =  Type.generic.sixteen
    render 'cycle'
  end
end
