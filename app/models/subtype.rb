# frozen_string_literal: true

class Subtype < Concept

  SYMBOLS = Realm.collect do |realm|
    Compass.behaviors.collect do |behavior|
       (realm.string + behavior.string).to_sym
    end
  end.flatten

  ALL = SYMBOLS.collect { |symbol| new symbol }

  def realm = Realm.send(string.first)
  def behavior = Compass.send(string.second)

  def name = behavior.name.gsub(' the ', " the #{realm.name} ")

end
