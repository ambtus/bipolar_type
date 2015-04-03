class DiscoverController < ApplicationController
  def show
    @answer = Answer.new(params[:id])
    render @answer.question
  end

end
