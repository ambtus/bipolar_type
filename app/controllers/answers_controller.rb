class AnswersController < ApplicationController

  def show
    @answer = Answer.new params[:id]
    @title = "Question ##{@answer.number} of 3"
    redirect_to type_path(@answer.type_path) and return if @answer.finished?
    @sixteen =  @answer.realm.subtypes
    render "cycle"
  end

end
