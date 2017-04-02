class Realm < Concept

  NAMES = %w{ emotional financial physical mental}

  ########
  ACRONYMS = %w{f t s n}
  ALL = ACRONYMS.collect {|letter| self.new letter}
  ACRONYMS.each {|letter| define_singleton_method(letter) { ALL[ACRONYMS.index(letter)] } }
  ########

  def subtypes; Subtype.all.select{|s| s.realm == self}; end
  def +(attitude); subtypes.find{|s| s.attitude == attitude}; end

  def description; NAMES[index]; end
  def symbol; path.upcase; end
  def name; description.capitalize; end
  def adverb; description + "ly"; end

end
