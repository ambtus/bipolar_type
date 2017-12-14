class Attitude < Concept

  STATES = %w{ obesity mania depression anorexia}

  ########
  ACRONYMS = STATES.map(&:first)
  ALL = ACRONYMS.collect {|letter| self.new letter}
  ACRONYMS.each do |letter|
    define_singleton_method(letter) {ALL[ACRONYMS.index(letter)]}
  end
  ########

  def subtypes; Subtype.all.select{|s| s.attitude == self}; end
  def +(realm); subtypes.find{|s| s.realm == realm}; end

  def state; STATES[index]; end
  def name; state.titleize; end


end
