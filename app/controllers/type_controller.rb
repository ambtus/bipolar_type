class TypeController < ApplicationController

  def show
    if params[:id].blank?
      render :start
    elsif Quad.paths.include?(params[:id])
      @quad = Quad.send(params[:id])
      @first, @second, @third, @fourth = @quad.subtypes
      render :quad
    elsif Realm.paths.include?(params[:id])
      @quad = Realm.send(params[:id]).quad
      @first, @second, @third, @fourth = @quad.subtypes
      render :quad
    else
      render :start
    end
  end

end
