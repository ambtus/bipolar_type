class AnswersController < ApplicationController

  def show
    @answer = Answer.new params[:id]
    if @answer.finished?
      @title = 'Verification'
      render 'verification'
    else
      @title = "Question ##{@answer.number} of 3"
      render 'nature'
    end
  end

end
