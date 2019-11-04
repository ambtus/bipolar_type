class AnswersController < ApplicationController

  def show
    @answer = Answer.new params[:id]
    @group_by = true unless params[:group_by] == "a"
    redirect_to type_path(@answer.type_path) and return if @answer.finished?
  end

end
