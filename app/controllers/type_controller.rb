class TypeController < ApplicationController

  def show
    if params[:id].blank?
      render :start
    elsif %w{subtypes quads}.include? params[:id]
      render params[:id]
    elsif Realm.paths.include?(params[:id])
      @quad = Realm.send(params[:id]).quad
      render :quad
    elsif Attitude.paths.include?(params[:id])
      @quad = Attitude.send(params[:id]).quad
      render :quad
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
