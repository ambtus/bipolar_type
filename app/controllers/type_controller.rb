class TypeController < ApplicationController

  def show
    if params[:id].blank?
      render :start
    elsif params[:id] == "subtypes"
      @realms = Realm.all
      render :subtypes
    elsif Realm.paths.include?(params[:id])
      @quad = Realm.send(params[:id]).quad
      render :quad
    elsif Quad.paths.include?(params[:id])
      @quad = Quad.send(params[:id])
      render :quad
    else
      render :start
    end
  end

end
