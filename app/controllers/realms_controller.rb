# frozen_string_literal: true

class RealmsController < ApplicationController

  def index
    @title = 'Type'
    render 'realms'
  end
end
