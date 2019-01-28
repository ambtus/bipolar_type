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

  def adjective; %w{physical affective mental financial}[index]; end

  def energy; %w{glucose affect data currency}[index]; end
  def reserves; %w{fat attachments knowledge savings}[index]; end
  def resources; %w{food opinions results income}[index]; end
  def goal; %w{place person idea thing}[index]; end
  def goals; goal.s; end
  def achieve; %w{go tell review buy}[index]; end
  def achieved; %w{gone told reviewed bought}[index]; end

  def achieve_goals; [achieve, goals].join(" "); end
  def use_energy; %w{walk talk think shop}[index]; end
  def act; use_energy; end
  def actions; act.ing; end

  def take; %w{eat listen\ to look\ at collect}[index]; end
  def refuel; take.split.first; end
  def get_energy; [take, resources].join(" "); end

  def appear; %w{tastes sound look feels}[index]; end
  def appearance; %w{taste sound look feel}[index]; end
  def appealing; %w{sweet love colorful bonus}[index]; end
  def disagreable; %w{savory hate moving ??}[index]; end

  def thing; %w{where one thing thing}[index]; end
  def anything; "any#{thing}"; end
  def something; "some#{thing}"; end
  def everything; "every#{thing}"; end
  def do_something; [achieve, something].join(" "); end

  def do_it; %w{travel communicate decide ??}[index]; end
  def cheat; %w{ride write guess ??}[index]; end

  def storage; %w{body heart head bank}[index]; end
  def death; %w{starvation suicide ignorance exposure}[index]; end
  def dying; %w{starving suicidal forgetful destitue}[index]; end

  def extras; %w{carbs songs details wages}[index]; end
  def staples; %w{protein speeches shapes investment\ income}[index]; end
  def get_extras; [take, extras].join(" "); end
  def get_staples; [take, staples].join(" "); end

  def neuro; %w{serotonin oxytocin glutamate dopamine}[index]; end

end
