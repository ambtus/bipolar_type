class Attitude < Concept

  NAMES = %w{consumer non-producer non-consumer producer}

  ########
  ACRONYMS = %w{ep ip ij ej}
  ALL = ACRONYMS.collect {|letter| self.new letter}
  ACRONYMS.each {|letter| define_singleton_method(letter) { ALL[ACRONYMS.index(letter)] } }
  ########

  def mbti; ACRONYMS[index]; end

  def subtypes; Subtype.all.select{|s| s.attitude == self}; end
  def +(realm); subtypes.find{|s| s.realm == realm}; end

  def description; NAMES[index]; end
  def symbol; path.upcase; end
  def name; description.titleize; end

end
