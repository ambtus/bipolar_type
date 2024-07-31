class SubtypesController < ApplicationController
  def show
    @subtype = Subtype.send params[:id]
  end
end
