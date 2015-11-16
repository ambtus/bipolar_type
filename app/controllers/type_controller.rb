class TypeController < ApplicationController

  def show
    if params[:id].blank?
      render :start
    elsif %w{realms}.include? params[:id]
      render params[:id]
    elsif Energy.paths.include?(params[:id])
      @energy = Energy.send(params[:id])
      render :realm
    else
      @quad = Quad.new(params[:id])
      render :quad
    end
  end

end
