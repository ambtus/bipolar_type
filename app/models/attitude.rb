class Attitude < Concept

  ########
  ACRONYMS = %w{is ds ir dr}
  ALL = ACRONYMS.collect {|letter| self.new letter}
  ACRONYMS.each do |letter|
    define_singleton_method(letter) {ALL[ACRONYMS.index(letter)]}
  end
  ########

  def increase?; path.first == "i"; end
  def strength?; path.second == "s"; end

  def first; increase? ? "Increase" : "Decrease"; end
  def second; strength? ? "Strength" : "Reserves"; end
  def name; [first, second].join(" "); end

  def subtypes; Subtype.all.select{|s| s.attitude == self}; end
  def +(realm); subtypes.find{|s| s.realm == realm}; end

end
