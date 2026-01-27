# frozen_string_literal: true

module ApplicationHelper

  def popup(concept, *methods)
    thing = concept
    methods.each do |meth|
      thing = thing.send(meth)
    end
    text = "#{thing} (#{concept})"
    link_to text, concept_path(concept.path), class: 'popup', target: '_blank'
  end

end
