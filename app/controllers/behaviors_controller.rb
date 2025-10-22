# frozen_string_literal: true

class BehaviorsController < ApplicationController
  def index
    @title = '16 Behaviors'
    render 'behaviors'
  end

  def show
    @thing = Behavior.find params[:id]
    @title = @thing.title
    render 'concept'
  end
end
