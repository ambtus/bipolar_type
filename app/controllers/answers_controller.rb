class AnswersController < ApplicationController

  def show
    @answer = Answer.new params[:id]
    redirect_to type_path(@answer.type_path) and return if @answer.finished?
    @title = "##{@answer.number} of 3"
    @choice = @answer.choice
    render 'answer'
  end

end
