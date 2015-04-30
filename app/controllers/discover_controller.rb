class DiscoverController < ApplicationController
  def show
    @answer = Answer.new(params[:id])
    if @answer.number < 5
      render :behavior
    elsif @answer.number == 9
      redirect_to type_path(@answer.type_path) and return
    else
      render :subtype
    end
  end

end
