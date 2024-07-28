class TypesController < ApplicationController
  def show
    @type = Type.send params[:id]
    @dominant = @type.dominant_realm
  end

  def me; redirect_to action: 'show', id: Type.my_path; end
end
