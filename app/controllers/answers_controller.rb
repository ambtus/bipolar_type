class AnswersController < ApplicationController

  def show
    @answer = Answer.new params[:id]
    if @answer.finished?
      @path = @answer.type_path
      render "hours"
    elsif @answer.nurtured?
      redirect_to type_path(@answer.type_path) and return
    elsif @answer.natured?
      render "nurture"
    else
     @phase = @answer.phase
     render "nature"
    end
  end

end
