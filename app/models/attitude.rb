class Attitude < Concept

  NAMES = %w{get-less use-more get-more use-less}

  ########
  ACRONYMS = %w{ep ej ip ij}
  ALL = ACRONYMS.collect {|letter| self.new letter}
  ACRONYMS.each do |letter|
    define_singleton_method(letter) {ALL[ACRONYMS.index(letter)]}
  end
  ########

  def mbti; ACRONYMS[index]; end

  def subtypes; Subtype.all.select{|s| s.attitude == self}; end
  def +(realm); subtypes.find{|s| s.realm == realm}; end

  def description; NAMES[index]; end
  def symbol; path.upcase; end
  def name; description.titleize; end

  def first; mbti.first; end
  def second; mbti.second; end

end
