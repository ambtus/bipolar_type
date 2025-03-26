class QuadsController < ApplicationController

  def show
    @quad = Quad.find params[:id]
    render 'quad'
  end

  def me
    redirect_to action: 'show', id: Quad.my_path
  end
end
