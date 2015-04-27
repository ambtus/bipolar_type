class TheoryController < ApplicationController

  def show
    render params[:id]
  end

end
