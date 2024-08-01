class SubtypesController < ApplicationController
  def show
    @subtype = Subtype.send params[:id]
    @name = @subtype.symbolic_name
    @function = @subtype.behavior.mbti.downcase
    @adjective = @subtype.realm.adjective
    @attitude = @subtype.position.mbti.downcase
  end
end
