class TypeController < ApplicationController
  def show
    if params[:id].blank?
      render :start
    else
      render params[:id]
    end
  end

end
