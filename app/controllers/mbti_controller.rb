class MbtiController < ApplicationController

  def show
     begin
      @mbti = Mbti.new(params[:id])
      render :rationale
     rescue 
       begin
        @quad = Quad.new(params[:id])
      rescue
        redirect_to root_path and return
      end
    end
  end

end
