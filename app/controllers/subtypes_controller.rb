# frozen_string_literal: true

class SubtypesController < ApplicationController
  def index
    @title = '16 Subtypes'
    render 'subtypes'
  end

  def show
    @subtype = Subtype.find params[:id]
    @title = @subtype.title
    render 'subtype'
  end
end
