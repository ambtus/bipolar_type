class RealmsController < ApplicationController
  def show
    @realm = Realm.send params[:id]
    @title = "The #{@realm.name} Realm"
    render "realm"
  end
end
