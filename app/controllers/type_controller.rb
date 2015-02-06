class TypeController < ApplicationController

  ARRAY=%w{attitudes d s n o bipolar}

  def show
    if params[:id].blank?
      @next = ARRAY.first
      render :start
    elsif ARRAY[1,4].include?(params[:id])
      @next = ARRAY[ARRAY.index(params[:id]).next]
      I18n.with_locale(params[:id]) { render :type }
    else
      @next = ARRAY[ARRAY.index(params[:id]).next]
      I18n.with_locale(params[:id]) { render params[:id] }
    end
  end

end
