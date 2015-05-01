class DiscoverController < ApplicationController
  def show
    @answer = Answer.new(params[:id])
    if @answer.number < 5
      render :type
    elsif @answer.number == 9
      redirect_to type_path(@answer.type_path) and return
    else
      render :problem
    end
  end

end
