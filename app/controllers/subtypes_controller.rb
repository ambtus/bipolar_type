class SubtypesController < ApplicationController
  def index
    render 'subtypes'
  end

  def show
    @subtype = Subtype.find_by params[:id]
    render 'subtype'
  end
end
