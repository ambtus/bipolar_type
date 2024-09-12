class AnswersController < ApplicationController

  def show
    get_words
    @answer = Answer.new params[:id]
    redirect_to type_path(@answer.type_index) and return if @answer.finished?
    render 'answer'
  end

end
