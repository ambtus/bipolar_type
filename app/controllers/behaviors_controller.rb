# frozen_string_literal: true

class BehaviorsController < ApplicationController
  def index
    @title = '16 Behaviors'
    render 'behaviors'
  end

  def show
    @concept = Behavior.find params[:id]
    @title = @concept.title
    render 'concept'
  end
end
