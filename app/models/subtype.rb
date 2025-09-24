# frozen_string_literal: true

class Subtype < Concept
  SYMBOLS = Realm.all.collect do |realm|
    Mood.all.collect do |mood|
      (realm.string + mood.string).to_sym
    end
  end.flatten

  ALL = SYMBOLS.collect { |symbol| new symbol }

  def realm = Realm.find(string.first)
  def mood = Mood.find(string.second)

  def behaviors = mood.attitudes.add(realm)
  def episode = [adjective, mood.episode].to_phrase

  %i[adjective adverb reserves output intake internals externals].each do |meth|
    delegate meth, to: :realm
  end
  %i[season location left? top? right? bottom?].each do |meth|
    delegate meth, to: :mood
  end

  def words = File.readlines("app/words/#{string}", chomp: true)

  def opposite = realm + mood.opposite

  def better = realm + mood.better
  def worse = realm + mood.worse

  def goal
    case mood.symbol
    when :e
      "fatter #{realm.internals}"
    when :i
      "thinner #{realm.internals}"
    when :p
      "#{realm.adjective} freedom"
    when :j
      "#{realm.adjective} productivity"
    end
  end

  def how
    case mood.symbol
    when :e
      "gain necessary #{realm.reserves}"
    when :i
      "lose excess #{realm.reserves}"
    when :p
      "flee from #{realm.externals}"
    when :j
      "fight for your #{realm.externals}"
    end
  end

end
