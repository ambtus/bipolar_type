class RealmsController < ApplicationController
  def show; setup(params[:id]); end

  def cycle; setup(Realm.generic.path); end

  def setup(id)
    @realm = Realm.send id
    @realms = Realm.with_generic.without(@realm)
    @title = "The #{@realm.name} Cycle"
    @sixteen =  Type.new(@realm.mbti * 4).sixteen
    render 'cycle'
  end

end
