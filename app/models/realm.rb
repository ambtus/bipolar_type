class Realm < Concept

  SYMBOLS = %w{S N F T}
  ########
  ALL = SYMBOLS.collect {|symbol| self.new symbol}
  SYMBOLS.each do |path|
    define_singleton_method(path) {ALL[SYMBOLS.index(path)]}
  end
  %w{first second third fourth}.each_with_index do |ordinal, index|
    define_singleton_method(ordinal) {ALL[index]}
  end
  ########

  def subtypes; Subtype.all.select{|s| s.realm == self}; end
  def +(attitude); subtypes.find{|s| s.attitude == attitude}; end

  def adjective; %w{physical mental affective financial }[index]; end
  def name; adjective.titleize; end

end
