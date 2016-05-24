class DiscoverController < ApplicationController
  def show
    @answer = Answer.new params[:id]
    redirect_to type_path(@answer.quad_path) and return if @answer.finished?
    #render "sensitivity" and return if @answer.number.odd?
    #render "tendency" and return if @answer.number.even?
  end
end
