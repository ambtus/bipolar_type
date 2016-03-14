class TypeController < ApplicationController

  def show
    if params[:id].blank?
      render :start
    elsif %w{overview subtypes}.include? params[:id]
      render params[:id]
    elsif Realm.paths.include?(params[:id])
      @quad = Realm.send(params[:id]).quad
      render :quad
    elsif Attitude.paths.include?(params[:id])
      @quad = Attitude.send(params[:id]).quad
      render :quad
    elsif Quad.paths.include?(params[:id])
      @quad = Quad.send(params[:id])
      render :quad
    else
      render :start
    end
  end

end
