class DiscoverController < ApplicationController
  def show
    @answer = Answer.new(params[:id])
  end

end
