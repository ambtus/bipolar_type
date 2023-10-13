class BehaviorsController < ApplicationController
  def show
    if params[:id].length == 2
      @phase = Phase.send params[:id]
      @title = "The #{@phase.name} Phase".html_safe
      render 'phase'
    else
      @behavior = Behavior.send params[:id]
      @title = "The #{@behavior.symbol} Behavior".html_safe
      render 'behavior'
    end
  end
end
