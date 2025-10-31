# frozen_string_literal: true

class AttitudesController < ApplicationController
  def show
    @concept = Attitude.find params[:id]
    @title = @concept.title
    render 'concept'
  end
end
