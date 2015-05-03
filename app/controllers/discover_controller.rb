class DiscoverController < ApplicationController
  def show
    @answer = Answer.new(params[:id])
    if @answer.number < 5
      render :trait
    elsif @answer.number == 5
      render :type
    end
  end

end
