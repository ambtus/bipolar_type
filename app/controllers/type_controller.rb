class TypeController < ApplicationController

  def show
    if params[:id].blank?
      render :start
    elsif %w{realms attitudes bipolar}.include? params[:id]
      @short_only = true
      render params[:id]
    elsif Realm.paths.include?(params[:id])
      @container = Realm.send(params[:id])
      @full = true
    elsif Attitude.paths.include?(params[:id])
      @container = Attitude.send(params[:id])
      @full = true
      render :attitude
    elsif Subtype.paths.include?(params[:id])
      @subtype = Subtype.send(params[:id])
      @full = true
      render :subtype
    else
      @container = Quad.new(params[:id])
      render :show
    end
  end

end
