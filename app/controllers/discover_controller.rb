class DiscoverController < ApplicationController
  def show
    @answer = Answer.new params[:id]
    redirect_to type_path(@answer.quad_path) and return if @answer.finished?
    render "nature" and return if @answer.number.odd?
    render "nurture" and return if @answer.number.even?
  end
end
