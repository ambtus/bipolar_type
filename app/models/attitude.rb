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

  def adjective; %w{depressed conservative liberal manic}[index]; end

  def outside?; [0,3].include?(index); end

  def health; outside? ? "dangerous" : "unhealthy" ;end
  def episode; index > 1 ? "mania" : "depression"; end

end
