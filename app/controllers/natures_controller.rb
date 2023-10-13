class NaturesController < ApplicationController

  def show
    @nature = Nature.new params[:id]
    if @nature.finished?
      redirect_to nurture_path(@nature.nurture_path) and return
    else
      @title = "Nature ##{@nature.number} of 4"
      render 'nature'
    end
  end

end
