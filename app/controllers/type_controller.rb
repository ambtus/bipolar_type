class TypeController < ApplicationController

  def show
    if params[:id].blank?
      render :start
    elsif %w{outline theory}.include?(params[:id])
      render params[:id]
    elsif Attitude::LETTERS.include?(params[:id])
      @attitude = Attitude.find(params[:id])
      render :attitude
    elsif Realm::LETTERS.include?(params[:id])
      @realm = Realm.find(params[:id])
      render :realm
    elsif Subtype::LETTERS.include?(params[:id])
      @subtype = Subtype.find(params[:id])
      render :subtype
    elsif Nurture::LETTERS.include?(params[:id])
      @nurture = Nurture.find(params[:id])
      render :nurture
    elsif Nature::LETTERS.include?(params[:id])
      @nature = Nature.find(params[:id])
      render :nature
    else
      @type = Type.new(params[:id])
      render :type
    end
  end

end
