class AnswersController < ApplicationController

  def show
    @answer = Answer.new params[:id]
    @title = "Question ##{@answer.number} of 8"
    if @answer.nurtured?
      redirect_to type_path(@answer.type_path)
    elsif @answer.natured?
      render 'nurture'
    else
     @phase = @answer.phase
     render 'nature'
    end
  end

end
