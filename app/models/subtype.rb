# frozen_string_literal: true

class Subtype < Concept
  SYMBOLS = Realm.linear.collect do |realm|
    Mood.all.collect do |mood|
      (realm.string + mood.string).to_sym
    end
  end.flatten

  ALL = SYMBOLS.collect { |symbol| new symbol }

  def realm = Realm.find(string.first)
  def mood = Mood.find(string.second)

  def season = [adjective, mood.season].to_phrase

  %i[adjective adverb reserves output intake internals externals
     ip ep ij ej].each do |meth|
    delegate meth, to: :realm
  end
  %i[season].each do |meth|
    delegate meth, to: :mood
  end

  def words = File.readlines("app/words/#{string}", chomp: true)

  def goal = [adjective, mood.goal].to_phrase
  alias link :goal

  def balance = [adjective, mood.balance].to_phrase

  def how
    case string.last
    when 'e'
      "gain wanted #{realm.reserves}"
    when 'i'
      "lose unwanted #{realm.reserves}"
    when 'p'
      "flee from #{realm.externals}"
    when 'j'
      "fight for your #{realm.externals}"
    else
      raise "unknown mood for #{self}"
    end
  end
end
