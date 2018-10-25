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

  def nurture; %w{ thin active fat passive}[index]; end
  def disorder; %w{ anorexia mania obesity depression}[index]; end
  def name; disorder.titleize; end

  def behavior; %w{get use get use}[index]; end
  def amount; %w{little much much little}[index]; end
  def change; amount == "little" ? "more" : "less"; end

  def focus; %w{resources goals resources goals}[index]; end

  def subtypes; Subtype.all.select{|s| s.attitude == self}; end
  def +(realm); subtypes.find{|s| s.realm == realm}; end

end
