class AnswersController < ApplicationController

  def show
    @answer = Answer.new params[:id]
    redirect_to quad_path(@answer.quad_path) and return if @answer.finished?
    @title = "Question ##{@answer.number} of 4"
    render 'answer'
  end

end
