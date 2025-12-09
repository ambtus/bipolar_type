# frozen_string_literal: true

class NaturesController < ApplicationController
  def index
    @title = Nature.title
    @sort_by = params[:format] || 'e'
    render 'natures'
  end

  def show
    @subtypes = params[:id].scan(/../).collect { |x| Subtype.find(x) }
    @nature = Nature.find_by @subtypes
    @title = @nature.title
    siblings = Type.with(@subtypes)
    @bp1 = siblings.first
    @bp2 = siblings.second
    render 'nature'
  end
end
