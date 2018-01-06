class SubtypesController < ApplicationController
  def index; end
  def show
    begin
      @subtype = Subtype.send params[:id]
      @name = @subtype.name
      @subtypes = @subtype.siblings
    rescue NoMethodError
      redirect_to attitude_path(params[:id].gsub(/en/, ""))
    end
  end
end
