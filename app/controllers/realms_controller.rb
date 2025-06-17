class RealmsController < ApplicationController
  def show
    @realm = Realm.find(params[:id])
    render 'realm'
  end
end
