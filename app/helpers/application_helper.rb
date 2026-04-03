# frozen_string_literal: true

module ApplicationHelper

  def definition(concept, meth = :noop)
    link_to concept.name.send(meth).capitalize, concept_path(concept.path), class: 'definition'
  end

  def find_class(chosen, realm, action)
    if chosen.include? [realm, action]
      'bold'
    elsif chosen.flatten.include?(realm) || chosen.flatten.include?(action)
      'strikethrough'
    else
      'normal'
    end
  end
end
