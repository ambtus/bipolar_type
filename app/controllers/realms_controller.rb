class RealmsController < ApplicationController
  def index; end

  def show
    @realm = Realm.send params[:id]
    @mbti = @realm.mbti
    @subtypes = @realm.subtypes
  end
end
