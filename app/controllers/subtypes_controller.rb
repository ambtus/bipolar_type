class SubtypesController < ApplicationController
  def index; end
  def show
    @subtype = Subtype.send params[:id]
  end
end
