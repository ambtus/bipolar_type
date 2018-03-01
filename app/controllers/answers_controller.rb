class AnswersController < ApplicationController

  def show
    @answer = Answer.new params[:id]
    redirect_to type_path(@answer.type_path) and return if @answer.finished?
    @by_attitude = true if params[:sort] == "a"
    @realm = @answer.realm
    @subtypes = @realm.subtypes
  end

end
