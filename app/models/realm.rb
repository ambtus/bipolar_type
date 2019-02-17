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

  def adjective; %w{physical mental affective financial}[index]; end

  def energy; %w{glucose data affect currency}[index]; end
  def aka; %w{calories information emotions money}[index]; end
  def stored_energy; %w{fat knowledge love savings}[index]; end
  def storage; %w{body head heart bank}[index]; end

  ## To achieve goals
  def achieve; %w{go understand tell buy}[index]; end
  def goal; %w{place idea person thing}[index]; end
  def question; %w{where why who what}[index]; end
  def goals; goal.s; end
  def achieve_goals; [achieve, goals].join(" "); end
  def achieve_more; [achieve, "more", goals].join(" "); end

  def passive; %w{still calm silent frugal}[index]; end
  def thing; %w{where thing one thing}[index]; end
  def achieve_something; [achieve, "some#{thing}"].join(" "); end
  def achieve_anything; [achieve, "any#{thing}"].join(" "); end
  def them; %w{there them them them}[index]; end

  ## Use energy

  def low_energy_activities; %w{drive plan write pay\ upfront}[index]; end
  def high_energy_activities; %w{walk visualize talk use\ credit}[index]; end
  def tired; %w{sore stupid tongue-tied indebted}[index]; end

  ## Harvest resources

  def notice; %w{smell see hear touch}[index]; end
  def harvest; %w{eat look\ at listen\ to collect}[index]; end
  def resource; %w{food result voice income}[index]; end
  def resources; %w{food results voices income}[index]; end
  def harvest_resources; [harvest, resources].join(" "); end
  def harvest_something; [harvest, "something"].join(" "); end

  def empty; %w{hungry curious lonely envious}[index]; end

  ## To Get energy
  def get_less_energy; %w{eat look\ at read collect}[index]; end
  def get_more_energy; %w{eat look\ at listen\ to earn}[index]; end

  def low_energy_resources; %w{protein outlines words interest}[index]; end
  def high_energy_resources; %w{carbs details music wages}[index]; end

  def appear; %w{taste look sounds feel}[index]; end
  def good; %w{sweet colorful harmonious rewarding}[index]; end

  def low_energy_harvest; [get_less_energy, low_energy_resources].join(" "); end
  def high_energy_harvest; [get_more_energy, high_energy_resources].join(" "); end

  def highest_energy_harvest; [get_more_energy, good, high_energy_resources].join(" "); end

  def overwhelmed; %w{sick afraid weepy angry}[index]; end

end
