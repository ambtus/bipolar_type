class TypeController < ApplicationController

  def show
    if params[:id].blank?
      render :start
    elsif %w{realms}.include?(params[:id])
      render params[:id]
    elsif Tendency::LETTERS.include?(params[:id])
      @tendency = Tendency.find(params[:id])
      render :tendency
    elsif Pair::LETTERS.include?(params[:id])
      @pair = Pair.find(params[:id])
      render :pair
    elsif Quad::LETTERS.include?(params[:id])
      @quad = Quad.new(params[:id])
      render :quad
    else
      render :start
    end
  end

end
