class Realm < Concept

  ########
  ACRONYMS = %w{s t f n}
  ALL = ACRONYMS.collect {|letter| self.new letter}
  ACRONYMS.each do |letter|
    define_singleton_method(letter) {ALL[ACRONYMS.index(letter)]}
  end
  ########

  ADJECTIVES = %w{caloric financial social mental}
  def adjective; ADJECTIVES[index]; end
  def name; adjective.capitalize; end

  def locale; path.to_sym; end

  def subtypes; Subtype.all.select{|s| s.realm == self}; end
  def +(attitude); subtypes.find{|s| s.attitude == attitude}; end

  def mbti; path.upcase; end

end
