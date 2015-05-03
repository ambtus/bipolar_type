class TypeController < ApplicationController

  def show
    if params[:id].blank?
      render :start
    elsif %w{subtypes}.include?(params[:id])
      render params[:id]
    else
      @type = Type.new(params[:id])
    end
  end

end
