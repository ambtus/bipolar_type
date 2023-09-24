class BehaviorsController < ApplicationController
  def index; end
  def show
    if params[:id].length == 2
      @behavior = GenericBehavior.send params[:id]
    else
      @behavior = Behavior.send params[:id]
    end
    @name = @behavior.name
  end
end
