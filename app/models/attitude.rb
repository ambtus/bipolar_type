class Attitude < Concept

  ########
  ACRONYMS = %w{a b c d}
  ALL = ACRONYMS.collect {|letter| self.new letter}
  ACRONYMS.each do |letter|
    define_singleton_method(letter) {ALL[ACRONYMS.index(letter)]}
  end
  %w{first second third fourth}.each_with_index do |ordinal, index|
    define_singleton_method(ordinal) {ALL[index]}
  end
  ########

  def subtypes; Subtype.all.select{|s| s.attitude == self}; end
  def +(realm); subtypes.find{|s| s.realm == realm}; end

  def episode; %w{depression lethargy hypomania mania}[index]; end
  def name; episode.titleize; end

  def goal; index < 2 ? "strong" : "fat"; end

end
