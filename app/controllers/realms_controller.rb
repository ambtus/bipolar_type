class RealmsController < ApplicationController
  def index; end

  def show
    @realm = Realm.send params[:id]
    @subtypes = @realm.subtypes
  end
end
