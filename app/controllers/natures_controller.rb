# frozen_string_literal: true

class NaturesController < ApplicationController
  def show
    @concept = Nature.find params[:id]
    @title = Type.title(@concept.subtypes)
    @siblings = Type.with(@concept.subtypes)
    render 'nature'
  end

  def index
    @title = Nature.title
    @sort_by = params[:format] || 'e'
    render 'natures'
  end
end
