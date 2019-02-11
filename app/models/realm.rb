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

  def adjective; %w{social physical financial mental}[index]; end

  def energy; %w{affect glucose currency data}[index]; end
  def aka; %w{emotions calories money information}[index]; end
  def stored_energy; %w{ego fat savings knowledge}[index]; end

  ## To achieve goals
  def achieve; %w{tell go buy consider}[index]; end
  def goal; %w{person place thing idea}[index]; end
  def goals; goal.s; end
  def achieve_goals; [achieve, goals].join(" "); end
  def achieve_more; [achieve, "more", goals].join(" "); end

  def passive; %w{silent still frugal calm}[index]; end
  def thing; %w{one where thing thing}[index]; end
  def achieve_something; [achieve, "some#{thing}"].join(" "); end
  def achieve_anything; [achieve, "any#{thing}"].join(" "); end
  def them; %w{them there them them}[index]; end

  ## Use energy

  def low_energy_activities; %w{write drive pay\ upfront think}[index]; end
  def high_energy_activities; %w{talk walk use\ credit visualize}[index]; end
  def sore; %w{inarticulate sore indebted stupid}[index]; end

  ## Harvest resources

  def harvest; %w{hear taste touch see}[index]; end
  def resource; %w{voice food income answer}[index]; end
  def resources; %w{voices food income answers}[index]; end
  def harvest_resources; [harvest, resources].join(" "); end

  def empty; %w{lonely hungry envious curious}[index]; end

  ## To Get energy
  def get_less_energy; %w{read eat collect look\ at}[index]; end
  def get_more_energy; %w{listen\ to eat earn look\ at}[index]; end

  def low_energy_resources; %w{words protein interest outlines}[index]; end
  def high_energy_resources; %w{music carbs wages details}[index]; end

  def appear; %w{sounds taste feel look}[index]; end
  def good; %w{harmonious sweet rewarding colorful}[index]; end

  def low_energy_harvest; [get_less_energy, low_energy_resources].join(" "); end
  def high_energy_harvest; [get_more_energy, high_energy_resources].join(" "); end

  def highest_energy_harvest; [get_more_energy, good, high_energy_resources].join(" "); end

  def sick; %w{bad nauseated angry afraid}[index]; end

end
