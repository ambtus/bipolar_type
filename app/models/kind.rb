class Kind < Single

  ########
  ACRONYMS = %w{s e}
  ALL = ACRONYMS.collect {|letter| self.new letter}
  ACRONYMS.each {|letter| define_singleton_method(letter) { ALL[ACRONYMS.index(letter)] } }
  ########

  def natures; Nature.all.select{|a| a.kind == self}; end
  def +(action); natures.find{|a| a.action == action}; end

  def generic; choose Adjective, %w{strong energetic}; end

  def name; Phrase.new [generic.capitalize, symbol.parenthesize]; end

end
