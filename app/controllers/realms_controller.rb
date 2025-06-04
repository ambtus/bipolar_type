class RealmsController < ApplicationController

  def index
    render 'realms'
  end

  def show
    @realm = Realm.find_by(params[:id])
    render 'realm'
  end
end