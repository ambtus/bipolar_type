class SubtypesController < ApplicationController
  def show
    if params[:id].length == 1
      @behavior = Behavior.send params[:id]
    else
      @subtype = Subtype.send params[:id]
    end
  end
end
