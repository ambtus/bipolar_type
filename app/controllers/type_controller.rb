class TypeController < ApplicationController

  def show
    if params[:id].blank?
      render :start
    elsif %w{outline theory}.include?(params[:id])
      render params[:id]
    elsif Realm::LETTERS.include?(params[:id])
      @realm = Realm.find(params[:id])
      render :realm
    elsif Attitude::LETTERS.include?(params[:id])
      @attitude = Attitude.find(params[:id])
      render :attitude
    elsif Behavior::LETTERS.include?(params[:id])
      @behavior = Behavior.find(params[:id])
      render :behavior
    elsif Nature::LETTERS.include?(params[:id])
      @nature = Nature.find(params[:id])
      render :nature
    end
  end

end
