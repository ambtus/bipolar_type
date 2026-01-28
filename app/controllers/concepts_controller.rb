# frozen_string_literal: true

class ConceptsController < ApplicationController
  def index
    @title = 'Words'
  end
  def show
    klass = [Action, Behavior].find do |klass|
      klass.find(params[:id])
    end
    @concept = klass.send(params[:id])
    @title = @concept.title
    render klass.name.downcase, layout: 'definition'
  end
end
