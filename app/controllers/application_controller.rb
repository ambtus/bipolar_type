# frozen_string_literal: true

class ApplicationController < ActionController::Base
  def home = (@title = 'Introduction')
  def bipolar = (@title = 'The Bipolar Cycle')
  def symptoms = (@title = 'The Symptom Types')
  def concepts = (@title = 'BipolarType Concepts')
end
