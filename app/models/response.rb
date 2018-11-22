class Response < Concept

  SYMBOLS = %w{E I}

  ########
  ALL = SYMBOLS.collect {|symbol| self.new symbol}
  PATHS.each do |path|
    define_singleton_method(path) {ALL[PATHS.index(path)]}
  end
  %w{first second}.each_with_index do |ordinal, index|
    define_singleton_method(ordinal) {ALL[index]}
  end
  ########

  ## Generic
  def emotion; %w{anger fear}[index]; end
  def capacity; %w{strength speed}[index]; end
  def goal; %w{win escape}[index]; end
  def name; goal.titleize; end

  def direction; %w{approach avoid}[index]; end


  def subtypes; Subtype.all.select{|s| s.attitude == self}; end
  def +(realm); subtypes.find{|s| s.realm == realm}; end

end
