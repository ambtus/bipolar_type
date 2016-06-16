class ShortController < ApplicationController

  def show
     begin
        @quad = Quad.new(params[:id])
      rescue
        redirect_to root_path and return
      end
  end

end
