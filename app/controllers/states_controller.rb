class StatesController < ApplicationController
  def index; @states = State.all; end
  def show
    @state = State.send params[:id]
    @name = @state.name
    @subtypes = @state.subtypes
  end
end
