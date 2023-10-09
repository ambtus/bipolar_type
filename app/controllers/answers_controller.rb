class AnswersController < ApplicationController

  def show
    @answer = Answer.new params[:id]
    if @answer.finished?
      redirect_to nurture_path(@answer.type_path) and return
    else
      @title = "Question ##{@answer.number} of 3"
      render 'nature'
    end
  end

end
