class TypeController < ApplicationController

  def show
    if params[:id].blank?
      render :start
    elsif %w{subtypes}.include? params[:id]
      render params[:id]
    else
     begin
        @quad = Quad.new(params[:id])
        render :quad
      rescue
        render :start
      end
    end
  end

end
