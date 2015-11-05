class TypeController < ApplicationController

  def show
    if params[:id].blank?
      render :start
    elsif Quad::LETTERS.include?(params[:id])
      @quad = Quad.new(params[:id])
      render :quad
    elsif %w{subtypes quads}.include? params[:id]
      render params[:id]
    else
      render :start
    end
  end

end
