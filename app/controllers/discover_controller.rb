class DiscoverController < ApplicationController
  def show
    @answer = Answer.new(params[:id])
    if @answer.number == 6
      redirect_to type_path(@answer.type_path) and return
    end
  end

end
