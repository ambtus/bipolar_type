class NurturesController < ApplicationController

  def show
    @nurture = Nurture.new params[:id]
    if @nurture.finished?
      redirect_to type_path(@nurture.type_path) and return
    else
      @title = "Nurture ##{@nurture.number} of 4"
      render 'nurture'
    end
  end

end
