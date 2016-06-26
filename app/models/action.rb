class Action < Single

  ########
  ACRONYMS = %w{c p}
  ALL = ACRONYMS.collect {|letter| self.new letter}
  ACRONYMS.each {|letter| define_singleton_method(letter) { ALL[ACRONYMS.index(letter)] } }
  ########

  def natures; Nature.all.select{|a| a.action == self}; end
  def +(kind); natures.find{|a| a.kind == kind}; end

  def verb; choose Verb, %w{consume produce }; end
  def generic; verb.er; end

  def name; Phrase.new [generic.capitalize, symbol.parenthesize]; end

end
