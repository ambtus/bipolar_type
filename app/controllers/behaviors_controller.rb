class BehaviorsController < ApplicationController
  def show
    if params[:id].length == 2
      @behavior = Phase.send params[:id]
    else
      @behavior = Behavior.send params[:id]
    end
    @name = @behavior.name
    render "behavior"
  end
  def index; end
end
