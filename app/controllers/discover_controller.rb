class DiscoverController < ApplicationController
  def show
    @answer = Answer.new(params[:id])
    if @answer.number < 5
      @attitude = @answer.random_attitude
      render :state
    elsif @answer.number == 5
      redirect_to type_path(@answer.path)
    elsif @answer.number == 6
      render :realm
    end
  end

end
