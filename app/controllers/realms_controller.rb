class RealmsController < ApplicationController
  def show
    @realm = Realm.find(params[:id])
    render 'theory'
  end
end
