class DiscoverController < ApplicationController
  def show
    @answer = Answer.new(params[:id])
    redirect_to type_path(@answer.result) and return if @answer.finished?
    render @answer.question
  end

end
