class GenericProblem < Concept

  ########
  SYMBOLS = %w{W M E D}
  ALL = SYMBOLS.collect {|symbol| self.new symbol}
  SYMBOLS.each {|s| define_singleton_method(s) {ALL[SYMBOLS.index(s)]}}
  ########

  def problems; Realm.all.add(self); end

  def word; %w{weak mania exhausted depression }[index]; end

  def description
    case symbol
    when "W"
      "all Energy, no Strength"
    when "M"
      "all Use, no Get"
    when "E"
      "all Strength, no Energy"
    when "D"
      "all Get, no Use"
    end
  end

end
