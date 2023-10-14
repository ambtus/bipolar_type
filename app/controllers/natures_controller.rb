class NaturesController < ApplicationController

  def show
    @nature = Nature.new params[:id]
    if @nature.finished?
      redirect_to type_path(@nature.type_path) and return
    else
      @title = "Nature ##{@nature.number} of 4"
      render 'nature'
    end
  end

end
