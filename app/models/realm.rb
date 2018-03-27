class Realm < Concept

  ########
  ACRONYMS = %w{s n f t}
  ALL = ACRONYMS.collect {|letter| self.new letter}
  ACRONYMS.each do |letter|
    define_singleton_method(letter) {ALL[ACRONYMS.index(letter)]}
  end
  %w{first second third fourth}.each_with_index do |ordinal, index|
    define_singleton_method(ordinal) {ALL[index]}
  end
  ########

  def subtypes; Subtype.all.select{|s| s.realm == self}; end
  def +(attitude); subtypes.find{|s| s.attitude == attitude}; end

  def adjective; %w{physical mental spiritual material}[index]; end
  def name; adjective.capitalize; end
  def symbol; name.first; end

  def fat; %w{voluptuous knowledgeable self-confident rich}[index]; end
  def thin; %w{thin theoretical realistic cash-poor}[index]; end
  def weak; %w{still calm quiet unencumbered}[index]; end
  def strong; %w{strong smart eloquent wealthy}[index]; end


end
