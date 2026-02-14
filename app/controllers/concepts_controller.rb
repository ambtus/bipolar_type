# frozen_string_literal: true

class ConceptsController < ApplicationController
  def show
    klass = [Realm, Compass].find do |klass|
      klass.find(params[:id])
    end
    @concept = klass.send(params[:id])
    @title = @concept.title
    render klass.name.downcase, layout: 'definition'
  end
end
