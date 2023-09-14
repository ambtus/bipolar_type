class NurturesController < ApplicationController
  def index; @nurtures = Nurture.all; end
  def show
    @nurture = Nurture.send params[:id]
    @subtypes = @nurture.subtypes
  end
end
