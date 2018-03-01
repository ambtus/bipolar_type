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

  def adjective; %w{fatigued producer consumer overwhelmed}[index]; end
  def name; adjective.capitalize; end
  def symbol; name.first; end

  def happy?; %w{b c}.include? path; end
  def mood; happy? ? "public" : "unhappy"; end
  def consumer?; index.even? ; end
  def role; consumer? ? "consumer" : "producer"; end

  def description; [mood, role].join(" "); end
end
