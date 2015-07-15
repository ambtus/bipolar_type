class TypeController < ApplicationController

  def show
    if params[:id].blank?
      render :start
    elsif %w{outline theory}.include?(params[:id])
      render params[:id]
    elsif Qua::LETTERS.include?(params[:id])
      @qua = Qua.find(params[:id])
      render :qua
    elsif Realm::LETTERS.include?(params[:id])
      @realm = Realm.find(params[:id])
      render :realm
    elsif Attitude::LETTERS.include?(params[:id])
      @attitude = Attitude.find(params[:id])
      render :attitude
    elsif Behavior::LETTERS.include?(params[:id])
      @behavior = Behavior.find(params[:id])
      render :behavior
    elsif Subtype::LETTERS.include?(params[:id])
      @subtype = Subtype.find(params[:id])
      render :subtype
    elsif Nature::LETTERS.include?(params[:id])
      @nature = Nature.find(params[:id])
      render :nature
    elsif Type::LETTERS.include?(params[:id])
      @type = Type.find(params[:id])
      render :type
    end
  end

end
