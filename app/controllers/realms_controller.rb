class RealmsController < ApplicationController
  def index
  end

  def show
    @realm = Realm.send params[:id]
    @name = @realm.name
    @subtypes = @realm.subtypes
  end
end
