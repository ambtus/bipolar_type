# frozen_string_literal: true

class NaturesController < ApplicationController
  def index
    @title = Nature.title
    @sort_by = params[:format] || 'p'
    render 'natures'
  end

  def show
    @nature = Nature.find params[:id]
    if @nature.nil?
      redirect_to natures_path, alert: "“#{params[:id]}“ is not a valid nature path" and return
    end
    @title = @nature.title
    @bp1 = @nature.bp1
    @bp2 = @nature.bp2
    render 'nature'
  end
end
