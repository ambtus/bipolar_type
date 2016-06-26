class NaturesController < ApplicationController
  def index
  end
  def show
    @nature = Nature.send params[:id]
    @name = @nature.name
    @subtypes = @nature.subtypes
  end
end
