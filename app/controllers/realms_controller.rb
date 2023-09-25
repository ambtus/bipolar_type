class RealmsController < ApplicationController
  def show
    @realm = Realm.send params[:id]
    render "realm"
  end
end
