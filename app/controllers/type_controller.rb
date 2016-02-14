class TypeController < ApplicationController

  def show
    if params[:id].blank?
      render :start
    elsif Quad.paths.include?(params[:id])
      @quad = Quad.send(params[:id])
      render :quad
    elsif Realm.paths.include?(params[:id])
      @quad = Realm.send(params[:id]).quad
      render :quad
    else
      render :start
    end
  end

end
