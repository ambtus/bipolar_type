# frozen_string_literal: true

class SubtypesController < ApplicationController
  def index
    @title = Subtype.title
    render 'subtypes'
  end

  def show
    @concept = Subtype.find params[:id]
    @title = @concept.title
    render 'concept'
  end
end
