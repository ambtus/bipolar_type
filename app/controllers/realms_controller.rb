class RealmsController < ApplicationController
  def show; setup(params[:id]); end

  def subtypes; setup(Realm.generic.path); end

  def setup(id)
    @realm = Realm.send id
    @realms = Realm.with_generic.without(@realm)
    @title = "The #{@realm.name} Subtypes"
    @four_by_four = Type.new(@realm.letter * 4).four_by_four
    render 'realms'
  end

end
