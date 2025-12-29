# frozen_string_literal: true

class BehaviorsController < ApplicationController
  def index
    @title = Behavior.title
    render 'behaviors'
  end

  def show
    @behavior = Behavior.find params[:id]
    @error = true unless %w[red green].include? params[:format]
    @good = true if params[:format] == 'green'
    @title = @behavior.title(green: @good)
    render 'behavior'
  end
end
