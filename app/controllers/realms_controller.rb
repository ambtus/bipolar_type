class RealmsController < ApplicationController
  def show
    @realm = Realm.send params[:id]
    @title = @realm.inspect
    @class = "center"
    @omit = true
    render "realm"
  end
end
