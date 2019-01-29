class Realm < Concept

  SYMBOLS = %w{P A M F}

  ########
  ALL = SYMBOLS.collect {|symbol| self.new symbol}
  PATHS.each do |path|
    define_singleton_method(path) {ALL[PATHS.index(path)]}
  end
  ########

  def subtypes; Subtype.all.select{|s| s.realm == self}; end
  def +(attitude); subtypes.find{|s| s.attitude == attitude}; end

  def adjective; %w{physical emotional mental financial}[index]; end

  def energy; %w{glucose affect data currency}[index]; end
  def informal_energy; %w{calories emotions information money}[index]; end
  def reserves; %w{fat attachments knowledge savings}[index]; end
  def resources; %w{food feedback results income}[index]; end
  def take; %w{eat listen\ to look\ at collect}[index]; end
  def get; take; end
  def get_energy; take.split.first; end
  def got; %w{ate heard saw earned}[index]; end
  def gotten; %w{eaten heard seen earned}[index]; end
  def extras; %w{carbs songs details wages}[index]; end
  def staples; %w{protein speeches shapes investment\ income}[index]; end
  def refuel; [take, resources].join(" "); end
  def get_both; [take, staples, "and", extras].join(" "); end
  def get_either; [take, staples, "or", extras].join(" "); end
  def get_extras; [take, extras].join(" "); end
  def get_staples; [take, staples].join(" "); end

  def use_energy; %w{walk talk think shop}[index]; end
  def do_chores; use_energy; end
  def do; use_energy; end
  def did; use_energy.ed; end
  def chores; use_energy.ing; end
  def actions; do_chores.ing; end

  def in_circles; %w{in\ circles to\ yourself again for\ consumables}[index]; end
  def practice; [use_energy, in_circles].join(" "); end

  def goal; %w{place person idea thing}[index]; end
  def goals; goal.s; end
  def achieve; %w{go tell consider buy}[index]; end
  def achieved; %w{gone told considered bought}[index]; end
  def achieve_goals; [achieve, goals].join(" "); end
  def labor; [achieve, goals].join(" "); end

  def appear; %w{tastes sound look feels}[index]; end
  def appearance; %w{taste sound look feel}[index]; end
  def mild; %w{bland instrumental pastel easy}[index]; end
  def appealing; %w{sweet love beautiful bonus}[index]; end
  def disagreable; %w{savory hate moving ??}[index]; end
  def get_nice_extras; [take, appealing, extras].join(" "); end

  def thing; %w{where one thing thing}[index]; end
  def what; %w{where who what what}[index]; end
  def do_something; [achieve, something].join(" "); end

  def do_it; %w{travel communicate decide spend\ money}[index]; end
  def cheat; %w{drive write guess pay\ bills}[index]; end

  def storage; %w{body heart head bank}[index]; end
  def death; %w{starvation suicide ignorance exposure}[index]; end
  def dying; %w{starving suicidal deranged destitue}[index]; end

  def empty; "#{adjective}ly tired"; end
  def full; "#{adjective}ly restless"; end

  def neuro; %w{serotonin oxytocin glutamate dopamine}[index]; end

  def turn_on
    case energy
    when "glucose", "currency"
      "#{take} some quick #{extras}"
    when "affect"
      "put on some dance tunes"
    when "data"
      "turn on some bright lights"
    end
  end

end
