class SubtypesController < ApplicationController

  def show
    if params[:id] == "by_nature"
      render "by_nature" and return
    elsif params[:id] == "by_realm"
      render "by_realm" and return
    else
      @subtype = Subtype.send params[:id]
    end
  end
end
