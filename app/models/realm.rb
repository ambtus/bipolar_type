class Realm < Concept

  SYMBOLS = %w{S N F T}

  ########
  ALL = SYMBOLS.collect {|symbol| self.new symbol}
  PATHS.each do |path|
    define_singleton_method(path) {ALL[PATHS.index(path)]}
  end
  ########

  def subtypes; Subtype.all.select{|s| s.realm == self}; end
  def +(attitude); subtypes.find{|s| s.attitude == attitude}; end

  def adjective; %w{physical mental emotional financial}[index]; end

  def energy; %w{glucose data affect currency}[index]; end
  def nontechnical; %w{calories information emotions money}[index]; end

  ## Use energy
  def use_energy; %w{walk think talk pay}[index]; end

  ## To achieve goals
  def goal; %w{place idea person thing}[index]; end
  def goals; goal.s; end

  def achieve; %w{go understand tell buy}[index]; end
  def achieve_goals; [achieve, goals].join(" "); end

  ## Harvest resources

  def resource; %w{food result voice reward}[index]; end
  def resources; resource.s; end

  def harvest; %w{eat look\ for listen\ to compete\ for}[index]; end
  def harvest_resources; [harvest, resources].join(" "); end

  ## To get energy

  def get_energy; %w{eat look listen fight}[index]; end
  alias get :get_energy



  def gotten; %w{eaten seen heard won}[index]; end #anything

  def sick; %w{nauseous afraid ashamed angry}[index]; end

  def staples; %w{protein patterns praise investment\ income}[index]; end
  def get_staples; [harvest, staples].join(" "); end

  def triggers; %w{carbs details whines wages}[index]; end
  def get_triggers; [harvest, triggers].join(" "); end


  def empty; %w{hungry curious lonely poor}[index]; end
  def dying; %w{starving ignorant suicidal destitute}[index]; end
  def strength; %w{muscles rules vocabulary equity}[index]; end
  def thing; %w{where thing one thing}[index]; end #any… some… every…
  def nothing; %w{nowhere nothing nobody nothing}[index]; end #noone isn't a word
  def with; %w{for about about for}[index]; end #accomplish goals with
  def them; %w{there them them them}[index]; end
  def what; %w{where what who what}[index]; end

  def sore; %w{sore stupid misunderstood indebted}[index]; end
  def passive; %w{seated calm silent frugal}[index]; end
  def wh1; %w{where why who what}[index]; end

  def what_you_do; [wh1, "you want to", achieve].join(" "); end

  def neuro; %w{serotonin glutamate oxytocin dopamine}[index]; end
  def vessel; %w{body brain voice wallet}[index]; end
  def wastefully; %w{in\ circles again to\ myself off\ debts}[index]; end
  def waste_energy; "#{use_energy} #{wastefully}"; end
  alias splurge :waste_energy
  def dont_achieve; "#{use_energy} without trying to #{achieve}"; end

  def achieved; %w{went understood told bought}[index]; end
  def sense; %w{smell see hear touch}[index]; end
  def wh2; %w{what what whose what}[index]; end
  def sense_resources; [sense, resources].join(" "); end

  def notice; %w{taste see hear hold}[index]; end
  def appearance; %w{taste look sound feel}[index]; end
  alias appear :appearance

  def close; %w{close close cover open}[index]; end
  def sensors; %w{mouth eyes ears hands}[index]; end


end
