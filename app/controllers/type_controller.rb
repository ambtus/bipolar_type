class TypeController < ApplicationController

  def show
    if params[:id].blank?
      render :start
    elsif %w{subtypes quads by_realm}.include? params[:id]
      render params[:id]
    elsif Realm.paths.include?(params[:id])
      realm = Realm.send(params[:id])
      @quad = realm.quad
      @name = realm.name
      render :quad
    elsif Attitude.paths.include?(params[:id])
      attitude = Attitude.send(params[:id])
      @quad = attitude.quad
      @name = attitude.name
      render :quad
    else
     begin
        @quad = Quad.new(params[:id])
      rescue
        render :start and return
      end
      @name = @quad.name
      render :quad
    end
  end

end
