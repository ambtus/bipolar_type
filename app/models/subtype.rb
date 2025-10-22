# frozen_string_literal: true

class Subtype < Concept
  SYMBOLS = Realm.linear.collect do |realm|
    Mood.all.collect do |mood|
      mood.horizontal? ? (realm.string + mood.string) : (mood.string + realm.string)
    end.map(&:to_sym)
  end.flatten
  ALL = SYMBOLS.collect { |symbol| new symbol }
  SYMBOLS.each do |sym|
    define_singleton_method(sym) { ALL.find { |s| s.symbol == sym } }
  end

  def realm = Realm.all.find { |x| string.match x.string }
  def mood = Mood.all.find { |x| string.match x.string }

  %i[adjective adverb reserves name].each do |meth|
    delegate meth, to: :realm
  end
  %i[season goal].each do |meth|
    delegate meth, to: :mood
  end

  %i[intake output externals internals].each do |sym|
    define_method(sym) {realm.send(sym)}
  end

  def lines = File.readlines("words/#{string}", chomp: true)

  def title = [adjective, goal].to_phrase
  alias link :title

  def next = realm + mood.next
  def previous = realm + mood.previous
  def opposite = realm + mood.opposite

  def sibling_attitudes =  Attitude.all.select { |x| x.path.match? mood.path }

  def behaviors = sibling_attitudes.add(realm)

  Attitude.each do |attitude|
    define_method(attitude.symbol) {realm + attitude}
  end

  def seasonal = [season, adjective].to_phrase

end
