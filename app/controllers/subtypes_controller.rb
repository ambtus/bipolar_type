class SubtypesController < ApplicationController
  def index; end
  def show
    @subtype = Subtype.send params[:id]
    @mbti = @subtype.mbti
    @subtypes = @subtype.siblings
  end
end
