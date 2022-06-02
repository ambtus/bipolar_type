class SubtypesController < ApplicationController
  def index; @title = 'The 16 Subtypes'; end
  def show
    @subtype = Subtype.send params[:id]
    @title = @subtype.name
  end
end
