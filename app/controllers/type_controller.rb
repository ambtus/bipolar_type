class TypeController < ApplicationController

  def show
    if params[:id].blank?
      render :start
    elsif %w{subtypes}.include?(params[:id])
      render params[:id]
    elsif %w{a b c d}.include?(params[:id])
      @realm=Realm.find(params[:id])
      render "realm"
    elsif %w{e f g h}.include?(params[:id])
      @attitude=Attitude.find(params[:id])
      render "attitude"
    else
      @type = Type.new(params[:id])
    end
  end

end
