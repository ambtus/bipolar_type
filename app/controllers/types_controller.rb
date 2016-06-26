class TypesController < ApplicationController
  def index
  end
  def show
    begin
    @type = Type.send params[:id]
    @name = @type.name
    @subtypes = @type.subtypes
    rescue
      render :index
    end
  end
end
