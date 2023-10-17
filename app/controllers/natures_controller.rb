class NaturesController < ApplicationController

  def show
    @nature = Nature.new params[:id]
    if @nature.finished?
      if @nature.behaviors.size == 4
        redirect_to type_path(@nature.type_path) and return
      else
        @title = "Sorry, you did not define a BipolarType"
        @nature = Nature.first
        @question = @nature.question
        render 'nature'
      end
    else
      @title = "Nature ##{@nature.number} of 24"
      @question = @nature.question
      render 'nature'
    end
  end

end
