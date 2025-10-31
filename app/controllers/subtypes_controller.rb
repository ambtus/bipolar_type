# frozen_string_literal: true

class SubtypesController < ApplicationController
  def show
    @concept = Subtype.find params[:id]
    @title = @concept.title
    render 'concept'
  end
end
