class AnswersController < ApplicationController

  def show
    if params[:id].length == 2
      @answer = Answer.first
      @generic_behavior = GenericBehavior.send params[:id]
    else
      @answer = Answer.new params[:id]
      @generic_behavior = @answer.generic_behavior
    end
    redirect_to type_path(@answer.type_path) and return if @answer.finished?
    render "answer"
  end

end
