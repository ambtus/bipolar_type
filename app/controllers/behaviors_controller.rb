class BehaviorsController < ApplicationController
  def show
    if params[:id].length == 2
      @phase = Phase.send params[:id]
      render 'phase'
    else
      @behavior = Behavior.send params[:id]
      render 'behavior'
    end
  end
  def index; end
end
