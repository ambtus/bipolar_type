class AnswersController < ApplicationController

  def show
    if Phase::SYMBOLS.include? params[:id]
      @answer = Answer.first
      @phase = Phase.send params[:id]
    else
      @answer = Answer.new params[:id]
      @phase = @answer.phase
    end
    redirect_to type_path(@answer.type_path) and return if @answer.finished?
    render "answer"
  end

end
