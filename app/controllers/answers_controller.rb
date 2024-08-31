class AnswersController < ApplicationController

  def show
    @answer = Answer.new params[:id]
    @title = "Question ##{@answer.number} of 3"
    redirect_to type_path(@answer.type_index) and return if @answer.finished?
    if params[:commit] == 'Hide'
      hide
      redirect_to answer_path(@answer.path) and return
    end
    render 'answer'
  end

end
