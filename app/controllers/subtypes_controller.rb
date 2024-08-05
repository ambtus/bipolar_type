class SubtypesController < ApplicationController
  def show
    @subtype = Subtype.send params[:id]
    @name = @subtype.symbolic_name
  end
end
