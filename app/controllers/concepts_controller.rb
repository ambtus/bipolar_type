# frozen_string_literal: true

class ConceptsController < ApplicationController
  def show
    klass = [Action, Behavior, Mood, Realm, Subtype].find do |klass|
      klass.find(params[:id])
    end
    @concept = klass.send(params[:id])
    @title = @concept.title
    render 'concept', layout: 'popup'
  end
end
