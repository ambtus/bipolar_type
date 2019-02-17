class Attitude < Concept

  ########
  ALL = SYMBOLS.collect {|symbol| self.new symbol}
  PATHS.each do |path|
    define_singleton_method(path) {ALL[PATHS.index(path)]}
  end
  %w{first second third fourth}.each_with_index do |ordinal, index|
    define_singleton_method(ordinal) {ALL[index]}
  end
  ########

  def subtypes; Subtype.all.select{|s| s.attitude == self}; end
  def +(realm); subtypes.find{|s| s.realm == realm}; end

  NAMES = %w{ manic productive  appreciative depressed   }

  def adjective; NAMES[index]; end

  NAMES.each do |adjective|
    define_singleton_method(adjective.first) {ALL[NAMES.index(adjective)]}
  end

  def goals?; %w{productive manic}.include?(adjective); end
  def manic?; %w{appreciative manic}.include?(adjective); end
  def compulsive?; %w{depressed manic}.include?(adjective); end

  def pleasure; goals? ? "goals" : "resources"; end

end
