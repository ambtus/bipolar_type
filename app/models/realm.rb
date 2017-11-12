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

  def locale; path.to_sym; end

  def subtypes; Subtype.all.select{|s| s.realm == self}; end
  def +(attitude); subtypes.find{|s| s.attitude == attitude}; end

  def mbti; path.upcase; end

  REALMS = %w{physical mental spiritual material}
  def realm; REALMS[index]; end

  def name; realm.capitalize; end

end
