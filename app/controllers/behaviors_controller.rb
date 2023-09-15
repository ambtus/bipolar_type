class BehaviorsController < ApplicationController
  def index; end
  def show
    @behavior = Behavior.send params[:id]
    @name = @behavior.name
  end
end
