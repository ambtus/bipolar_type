class PositionsController < ApplicationController
  def show
    @position = Position.send params[:id]
    @title = @position.inspect
    @class = "center"
    @omit = true
    render "position"
  end
end
