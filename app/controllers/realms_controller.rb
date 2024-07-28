class RealmsController < ApplicationController
  def show
    @realm = Realm.send params[:id]
    @title = "The #{@realm.name} Cycle"
    @sixteen =  @realm.subtypes.collect{|s| Array.new(4,s)}.flatten
    render 'cycle'
  end

  def index; render 'realms' and return; end
end
