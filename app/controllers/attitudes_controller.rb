# frozen_string_literal: true

class AttitudesController < ApplicationController

  def index
    @title = 'Bipolar'
    render 'attitudes'
  end
end
