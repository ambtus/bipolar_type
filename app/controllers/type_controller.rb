class TypeController < ApplicationController

  def show
    if params[:id].blank?
      render :start
    elsif %w{theory outline realms attitudes subtypes quads}.include?(params[:id])
      @resort = params[:group_by]
      render params[:id]
    elsif Realm::LETTERS.include?(params[:id])
      @realm = Realm.find(params[:id])
      render :realm
    elsif Attitude::LETTERS.include?(params[:id])
      @attitude = Attitude.find(params[:id])
      render :attitude
    elsif Subtype::LETTERS.include?(params[:id])
      @subtype = Subtype.find(params[:id])
      render :subtype
    elsif Quad::LETTERS.include?(params[:id])
      @quad = Quad.find(params[:id])
      render :quad
    end
  end

end
