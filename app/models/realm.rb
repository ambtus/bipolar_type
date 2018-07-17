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
  def adverb; adjective + "ly"; end

  def energy; %w{calories facts opinions money}[index]; end
  def resources; %w{foods results stories tools}[index]; end
  def appear; %w{taste look sound feel}[index]; end
  def appreciate; "#{appear} good"; end
  def reserves; %w{fat knowledge conscience savings}[index]; end
  def goals; %w{actions plans relationships purchases}[index]; end

end
