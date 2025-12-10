# frozen_string_literal: true

class ActionsController < ApplicationController
  def index
    @title = Action.title
    render 'actions'
  end

  def show
    @concept = Action.find params[:id]
    @title = @concept.title
    render 'concept'
  end
end
