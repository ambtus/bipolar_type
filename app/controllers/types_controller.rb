class TypesController < ApplicationController
  def show
    begin
      @type = Type.new params[:id]
    rescue
      Rails.logger.debug "DEBUG: problems with #{params[:id]}"
      redirect_to root_path and return
    end
  end

  def index; end
end
