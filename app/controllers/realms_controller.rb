# frozen_string_literal: true

class RealmsController < ApplicationController

  def show
    @thing = Realm.find params[:id]
    @title = @thing.title
    render 'concept'
  end
end
