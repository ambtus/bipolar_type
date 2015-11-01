class TypeController < ApplicationController

  def show
    if params[:id].blank?
      render :start
    elsif %w{realms}.include?(params[:id])
      render params[:id]
    elsif Subtype::LETTERS.include?(params[:id])
      @subtype = Subtype.find(params[:id])
      render :subtype
    elsif Pair::LETTERS.include?(params[:id])
      @pair = Pair.find(params[:id])
      render :pair
    else
      @quad = Quad.new(params[:id])
      render :quad
    end
  end

end
