class DiscoverController < ApplicationController
  def show
    @answer = Answer.new(params[:id])
    if @answer.number < 5
      render :state
    elsif @answer.number == 5
      render :type
    elsif @answer.number == 6
      render :realm
    end
  end

end
