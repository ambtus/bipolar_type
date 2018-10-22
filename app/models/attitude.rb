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

  def nurture; %w{active thin fat passive}[index]; end
  def disorder; %w{mania anorexia obesity depression}[index]; end
  def name; disorder.titleize; end

  def behavior; [0,3].include?(index) ? "use" : "get"; end
  def amount; index.even? ? "much" : "little"; end
  def change; index.even? ? "less" : "more"; end
  def reason; [0,3].include?(index) ? "achieve" : "sense"; end

  def subtypes; Subtype.all.select{|s| s.attitude == self}; end
  def +(realm); subtypes.find{|s| s.realm == realm}; end

end
