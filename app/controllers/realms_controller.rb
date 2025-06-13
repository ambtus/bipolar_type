class RealmsController < ApplicationController

  def index
    render 'realms'
  end

  def show
    @realm = Realm.find(params[:id])
    render 'realm'
  end
end
