class TypeController < ApplicationController

  def show
    if params[:id].blank?
      render :start
    elsif %w{sad subtypes}.include?(params[:id])
      render params[:id]
    elsif %w{a b c d}.include?(params[:id])
      @attitude=Attitude.find(params[:id])
      render "attitude"
    elsif %w{e f g h}.include?(params[:id])
      @realm=Realm.find(params[:id])
      render "realm"
    else
      @type = Type.new(params[:id])
      @basic = @type.basic
    end
  end

end
