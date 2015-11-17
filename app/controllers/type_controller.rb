class TypeController < ApplicationController

  def show
    if params[:id].blank?
      render :start
    elsif %w{realms attitudes}.include? params[:id]
      @short_only = true
      render params[:id]
    elsif Realm.paths.include?(params[:id])
      @container = Realm.send(params[:id])
    elsif Attitude.paths.include?(params[:id])
      @container = Attitude.send(params[:id])
    else
      @container = Quad.new(params[:id])
    end
  end

end
