# frozen_string_literal: true

class ConceptsController < ApplicationController
  def show
    klass = [Realm, Attitude].find do |klass|
      klass.find(params[:id])
    end
    @concept = klass.send(params[:id])
    @title = @concept.title
    render klass.name.downcase, layout: 'definition'
  end
end
