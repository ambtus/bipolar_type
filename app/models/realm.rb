class Realm < Concept

  NAMES = %w{mental physical financial emotional} # must all start with different letters and initial letter must match locale

  def color; %w{green red gold blue }[index]; end

  ########
  ACRONYMS = NAMES.map(&:first)
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
