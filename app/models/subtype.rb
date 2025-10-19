# frozen_string_literal: true

class Subtype < Concept
  SYMBOLS = Realm.linear.collect do |realm|
    Mood.all.collect do |mood|
      (realm.string + mood.string).to_sym
    end
  end.flatten
  ALL = SYMBOLS.collect { |symbol| new symbol }
  SYMBOLS.each do |sym|
    define_singleton_method(sym) { ALL.find { |s| s.symbol == sym } }
  end

  def realm = Realm.find(string.first)
  def mood = Mood.find(string.second)

  %i[adjective adverb reserves].each do |meth|
    delegate meth, to: :realm
  end
  %i[season].each do |meth|
    delegate meth, to: :mood
  end

  def lines = File.readlines("words/#{string}", chomp: true)
  def link = lines.first

end
