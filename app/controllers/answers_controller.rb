class AnswersController < ApplicationController

  def show
    @answer = Answer.new params[:id]
    @group_by = params[:group_by] || "attitude"
    @realms = Realm.all
    redirect_to type_path(@answer.type_path) and return if @answer.finished?
  end

end
