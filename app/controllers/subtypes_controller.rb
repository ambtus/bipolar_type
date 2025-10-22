# frozen_string_literal: true

class SubtypesController < ApplicationController


  def show
    @thing = Subtype.find params[:id]
    @title = @thing.title
    render 'concept'
  end
end
