class DiscoverController < ApplicationController
  def show
    @answer = Answer.new params[:id]
    redirect_to type_path(@answer.quad_path) and return if @answer.finished?
  end
end
