# frozen_string_literal: true

class RealmsController < ApplicationController
  def index
    @title = Realm.title
    render 'realms'
  end

  def show
    @concept = Realm.find params[:id]
    @title = @concept.title
    render 'concept'
  end
end
