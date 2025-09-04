# frozen_string_literal: true

class RealmsController < ApplicationController

  Realm.adjectives.each do |thing|
    define_method thing do
      @title = thing.capitalize
    end
  end

end
