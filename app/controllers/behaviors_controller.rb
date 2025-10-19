# frozen_string_literal: true

class BehaviorsController < ApplicationController
  def index
    @title = '16 Behaviors'
    render 'behaviors'
  end

  def show
    @behavior = Behavior.find params[:id]
    @title = @behavior.title
    render 'behavior'
  end
end
