class TypeController < ApplicationController

  def show
    if params[:id].blank?
      render :start
    elsif %w{subtypes}.include? params[:id]
      render params[:id]
    else
     begin
        @quad = Quad.new(params[:id])
      rescue
        render :start and return
      end
      render :quad
    end
  end

end
