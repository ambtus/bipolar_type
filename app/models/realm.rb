class Realm < Concept

  SYMBOLS = %w{F S T N}

  ########
  ALL = SYMBOLS.collect {|symbol| self.new symbol}
  PATHS.each do |path|
    define_singleton_method(path) {ALL[PATHS.index(path)]}
  end
  ########

  def subtypes; Subtype.all.select{|s| s.realm == self}; end
  def +(attitude); subtypes.find{|s| s.attitude == attitude}; end

  def adjective; %w{affective physical financial mental}[index]; end

  def energy; %w{affect glucose currency data}[index]; end
  def aka; %w{emotions calories money information}[index]; end
  def stored_energy; %w{self-confidence fat savings knowledge}[index]; end

  ## Use energy
  def use_energy; "use #{aka}"; end

  ## To achieve goals
  def achieve; %w{tell go buy understand}[index]; end
  def goal; %w{person place thing idea}[index]; end
  def goals; goal.s; end
  def achieve_goals; [achieve, goals].join(" "); end

  ## Get energy

  def get_energy; "get #{aka}"; end

  ## By harvesting resources

  def harvest; %w{hear eat collect learn}[index]; end
  def resource; %w{story meal income results}[index]; end
  def resources; %w{stories meals income results}[index]; end
  def harvest_resources; [harvest, resources].join(" "); end

  ## Goals
  def thing; %w{one where thing thing}[index]; end
  def achieve_something; [achieve, "some#{thing}"].join(" "); end

  def them; %w{them there it it}[index]; end
  def achieve_them; [achieve, them].join(" "); end

  def use_energy_now; [high_energy_actions, goals].join(" "); end
  def use_energy_later; [low_energy_actions, goals].join(" "); end
  def high_energy_actions; %w{talk\ to walk charge synthesize}[index]; end
  def low_energy_actions; %w{write\ to drive save\ up\ for analyze}[index]; end

  ## Resources

  def harvest_something; [harvest, "something"].join(" "); end
  def harvest_them; [harvest, "it"].join(" "); end

  def get_energy_now; [harvest, high_energy_resources].join(" "); end
  def get_energy_later; [harvest, low_energy_resources].join(" "); end
  def high_energy_resources; %w{music carbs wages specifics}[index]; end
  def low_energy_resources; %w{words protein investment\ income generalities}[index]; end

end
