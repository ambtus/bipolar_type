class AnswersController < ApplicationController

  def show
    @answer = Answer.new params[:id]
    redirect_to type_path(@answer.type_path) and return if @answer.finished?
    @attitude = Attitude.all[@answer.index]
  end

end
