# frozen_string_literal: true

class BehaviorsController < ApplicationController
  def show
    @concept = Behavior.find params[:id]
    @title = @concept.title
    render 'concept'
  end
end
