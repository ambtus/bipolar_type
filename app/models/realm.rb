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
  def aka; %w{calories emotions information money}[index]; end

  def reserves; %w{fat attachments knowledge savings}[index]; end

  def use_energy; %w{walk talk think shop}[index]; end
  def do_chores; use_energy; end

  def goal; %w{place person idea thing}[index]; end
  def goals; goal.s; end
  def achieve; %w{go tell consider buy}[index]; end
  def achieve_goals; [achieve, goals].join(" "); end

  def take; %w{eat listen\ to look\ at collect}[index]; end
  def resources; %w{food feedback results income}[index]; end
  def refuel; [take, resources].join(" "); end

end
