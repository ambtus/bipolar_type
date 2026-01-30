# frozen_string_literal: true

module ApplicationHelper

  def definition(concept)
    link_to "#{concept.wise} (#{concept})", concept_path(concept.path), class: 'definition'
  end

end
