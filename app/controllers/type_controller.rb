class TypeController < ApplicationController

  def show
    if params[:id].blank?
      render :start
    elsif %w{types_static}.include?(params[:id])
      render params[:id], :layout => false
    elsif %w{outline theory types subtypes}.include?(params[:id])
      @resort = params[:sort_by]
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
    elsif Type::LETTERS.include?(params[:id])
      @type = Type.find(params[:id])
      render :type
    end
  end

end
