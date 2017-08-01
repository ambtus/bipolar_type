class SubtypesController < ApplicationController
  def index; end
  def show
    @subtype = Subtype.send params[:id]
    @name = @subtype.name
    @subtypes = @subtype.siblings
    @types = @subtype.types
  end
end
