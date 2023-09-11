class SubtypesController < ApplicationController
  def show
    @subtype = Subtype.find params[:id]
    @title = @subtype.name
    render "subtype"
  end

  def index; @title = 'The 16 Subtypes'; end
end
