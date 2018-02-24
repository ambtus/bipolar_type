class Realm < Concept

  ########
  ACRONYMS = %w{p m e f}
  ALL = ACRONYMS.collect {|letter| self.new letter}
  ACRONYMS.each do |letter|
    define_singleton_method(letter) {ALL[ACRONYMS.index(letter)]}
  end
  ########

  def siblings; Realm.all - [self]; end

  def subtypes; Subtype.all.select{|s| s.realm == self}; end
  def +(attitude); subtypes.find{|s| s.attitude == attitude}; end

  def adjective; %w{physical mental emotional financial}[index]; end
  def adverb; adjective + "ly"; end
  def name; adjective.capitalize; end

  def symbol; path.upcase; end

  def produce; %w{walk think talk spend}[index]; end

end
