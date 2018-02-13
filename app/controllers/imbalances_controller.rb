class ImbalancesController < ApplicationController
  def index; @imbalances = Imbalance.all; end
  def show
    @imbalance = Imbalance.send params[:id]
    @name = @imbalance.name
    @subtypes = @imbalance.subtypes
  end
end
