class Realm < Concept

  SYMBOLS = %w{S N F T}

  ########
  ALL = SYMBOLS.collect {|symbol| self.new symbol}
  PATHS.each do |path|
    define_singleton_method(path) {ALL[PATHS.index(path)]}
  end
  ########

  SYMBOLS.each do |symbol|
    define_singleton_method(symbol.downcase) {ALL[SYMBOLS.index(symbol)]}
  end

  def subtypes; Subtype.all.select{|s| s.realm == self}; end
  def +(attitude); subtypes.find{|s| s.attitude == attitude}; end

  def rights; ALL.select{|x| x.index > self.index}; end

  def adjective; %w{ physical mental social financial }[index]; end

  def get_energy; [get, energizers].to_phrase; end
  def get_strength; [get, strengtheners].to_phrase; end
  def get; %w{ eat watch hear earn }[index]; end
  def energizers; %w{ carbs details praise cash }[index]; end
  def strengtheners; %w{ protein patterns criticism credit }[index]; end

  def use_energy; ["use", energy].to_phrase; end
  def use_strength; ["use", strength].to_phrase; end

  def energy; %w{ energy specifics praise cash }[index]; end
  def strength; %w{ muscle rules criticism credit }[index]; end


end
