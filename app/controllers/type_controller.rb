class TypeController < ApplicationController

  def show
    if params[:id].blank?
      render :start
    elsif %w{realms subtypes quads}.include? params[:id]
      render params[:id]
    else
      @quad = Quad.new(params[:id])
      render :quad
    end
  end

end
