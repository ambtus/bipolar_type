class DiscoverController < ApplicationController
  def show
    @answer = Answer.new(params[:id])
    @subtypes = Subtype.all
    if @answer.number > 4
      redirect_to type_path(@answer.quad_path) and return
    end
  end

end
