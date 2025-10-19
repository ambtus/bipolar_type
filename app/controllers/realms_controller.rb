# frozen_string_literal: true

class RealmsController < ApplicationController
  def index
    @title = '4 Realms'
    render 'realms'
  end

  def show
    @realm = Realm.find params[:id]
    @title = @realm.title
    render 'realm'
  end
end
