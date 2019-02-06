class Realm < Concept

  SYMBOLS = %w{F S T N}

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

  def adjective; %w{affective physical financial mental}[index]; end

  def energy; %w{affect glucose currency data}[index]; end
  def aka; %w{emotions calories money information}[index]; end
  def stored_energy; %w{ego fat savings knowledge}[index]; end

  ## To achieve goals
  def achieve; %w{tell go buy understand}[index]; end
  def goal; %w{person place thing idea}[index]; end
  def goals; goal.s; end
  def achieve_goals; [achieve, goals].join(" "); end
  def achieve_more; [achieve, "more", goals].join(" "); end

  def passive; %w{silent still frugal calm}[index]; end
  def thing; %w{one where thing thing}[index]; end
  def achieve_something; [achieve, "some#{thing}"].join(" "); end

  ## Use energy

  def low_energy_activities; %w{write drive spend\ cash analyze\ linearly}[index]; end
  def high_energy_activities; %w{talk walk use\ credit visualize\ spatially}[index]; end


  ## Harvest resources

  def harvest; %w{hear taste touch see}[index]; end
  def resource; %w{feeling food income answer}[index]; end
  def resources; %w{feelings food income answers}[index]; end
  def harvest_resources; [harvest, resources].join(" "); end

  ## To Get energy
  def get_less_energy; %w{read eat collect look\ at}[index]; end
  def get_more_energy; %w{listen\ to eat earn look\ at}[index]; end

  def low_energy_resources; %w{words savories interest shapes}[index]; end
  def high_energy_resources; %w{music sweets wages colors}[index]; end

  def low_energy_harvest; [get_less_energy, low_energy_resources].join(" "); end
  def high_energy_harvest; [get_more_energy, high_energy_resources].join(" "); end

end
