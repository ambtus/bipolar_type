class TypesController < ApplicationController
  def show
    begin
    @type = Type.new params[:id]
    @mbti = @type.mbti
    @subtypes = @type.subtypes
    rescue
      redirect_to root_path and return
    end
  end
end
