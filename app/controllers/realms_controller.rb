# frozen_string_literal: true

class RealmsController < ApplicationController

  Realm.each do |realm|
    define_method realm.adjective do
      @realm = realm
      @title = @realm.adjective.capitalize
      render 'realm'
    end
  end

end
