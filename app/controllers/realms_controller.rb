class RealmsController < ApplicationController
  def index; @title = 'The Four Realms'; end

  def show
    @realm = Realm.send params[:id]
    @title = @realm.name
    @subtypes = @realm.subtypes
  end
end
