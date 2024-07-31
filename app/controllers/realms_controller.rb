class RealmsController < ApplicationController
  def show
    @realm = Realm.send params[:id]
    @title = "The #{@realm.name} Realm"
    @sixteen =  Type.new(@realm.mbti * 4).sixteen
    render 'cycle'
  end

  def index; render 'realms' and return; end
end
