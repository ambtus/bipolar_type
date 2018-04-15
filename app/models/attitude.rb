class Attitude < Concept

  ########
  ACRONYMS = %w{uc oc up op}
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

  def u_or_o; path.first == "u" ? "under" : "over"; end
  def c_or_p; path.second == "p" ? "consume" : "produce"; end
  def description; [u_or_o, c_or_p].join(" "); end

  def result; %w{manic fat depressed strong}[index]; end
  def name; result.titleize; end

end
