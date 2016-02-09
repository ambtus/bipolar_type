class TypeController < ApplicationController

  def show
    if params[:id].blank?
      render :start
    elsif params[:id] == "numbers"
      render :numbers
    elsif Quad.paths.include?(params[:id])
      @quad = Quad.send(params[:id])
      render :quad
    else
      render :start
    end
  end

end
