class TypesController < ApplicationController
  def index; end
  def show
    begin
    @type = Type.send params[:id]
    @name = @type.name
    @subtypes = @type.subtypes
    rescue
      redirect_to root_path and return
    end
  end
end
