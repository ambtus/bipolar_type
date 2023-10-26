class AnswersController < ApplicationController

  def show
    @answer = Answer.new params[:id]
    @realms = Realm::ALL
    @title = "Question ##{@answer.number} of 4"
    redirect_to type_path(@answer.type_path) and return if @answer.finished?
    render "answer"
  end

end
