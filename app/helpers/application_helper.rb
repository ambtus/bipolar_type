# frozen_string_literal: true

module ApplicationHelper
  def link_to_concept(concept)
    link_to concept.link, send("#{concept.class.name.downcase}_path", concept.path)
  end
end
