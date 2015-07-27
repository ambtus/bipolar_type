class DiscoverController < ApplicationController
  def show
    @answer = Answer.new(params[:id])
    if @answer.number > 3
      redirect_to type_path(@answer.quad_path) and return
    else
      render @answer.question
    end
  end

end
