class Attitude < Concept

  SYMBOLS = %w{EP EJ IP IJ}
  ########
  ALL = SYMBOLS.collect {|symbol| self.new symbol}
  SYMBOLS.each do |path|
    define_singleton_method(path) {ALL[SYMBOLS.index(path)]}
  end
  %w{first second third fourth}.each_with_index do |ordinal, index|
    define_singleton_method(ordinal) {ALL[index]}
  end
  ########

  def subtypes; Subtype.all.select{|s| s.attitude == self}; end
  def +(realm); subtypes.find{|s| s.realm == realm}; end

  def verb; symbol.first == "I" ? "get" : "use"; end
  def noun; symbol.last == "J" ? "strength" : "energy"; end
  def description; [verb, noun].to_phrase; end
  def name; description.titleize; end


end
