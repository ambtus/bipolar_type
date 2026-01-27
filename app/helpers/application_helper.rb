# frozen_string_literal: true

module ApplicationHelper

  def popup(concept, *methods)
    thing = concept
    methods.each do |meth|
      thing = thing.send(meth)
    end
    link_to "#{thing} (#{concept})", concept_path(concept.path), class: 'popup'
  end

end
