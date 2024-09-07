class AnswersController < ApplicationController

  def show
    get_words
    @answer = Answer.new params[:id]
    @phase = @answer.phase
    redirect_to type_path(@answer.type_index) and return if @answer.finished?
    if params[:commit]
      hide
      redirect_to answer_path(@answer.path) and return
    end
    render 'answer'
  end

end
