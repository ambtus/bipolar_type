class TypeController < ApplicationController

  def show
    if params[:id].blank?
      render :start
    elsif %w{bipolartypes}.include?(params[:id])
      render params[:id]
    elsif Realm::LETTERS.include?(params[:id])
      @realm = Realm.find(params[:id])
      render :realm
    elsif Attitude::LETTERS.include?(params[:id])
      @attitude = Attitude.find(params[:id])
      render :attitude
    else
      @type = Type.new(params[:id])
    end
  end

end
