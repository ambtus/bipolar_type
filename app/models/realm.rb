class Realm < Concept

  SYMBOLS = %w{S N F T}

  ########
  ALL = SYMBOLS.collect {|symbol| self.new symbol}
  PATHS = SYMBOLS.map(&:downcase)
  PATHS.each do |path|
    define_singleton_method(path) {ALL[PATHS.index(path)]}
  end
  ########

  def path; PATHS[index]; end

  def subtypes; Subtype.all.select{|s| s.realm == self}; end
  def +(attitude); subtypes.find{|s| s.attitude == attitude}; end

  def adjective; %w{physical mental emotional financial}[index]; end
  def name; adjective.capitalize; end

  def get; %w{eat watch listen compete}[index]; end
  def use; %w{walk think talk spend}[index]; end

  def energy; %w{calories information ego money}[index]; end

  def hit; %w{go make teach spend}[index]; end
  def target; %w{place decisions person things}[index]; end
  def targets; target.pluralize; end
  def use_energy; [hit, targets].to_phrase; end

  def seek; %w{eat watch listen\ to use}[index]; end
  def resource; %w{food result opinion tool}[index]; end
  def resources; resource.pluralize; end
  def get_energy; [seek, resources].to_phrase; end

  def empty; %w{anorexic ignorant suicidal poor}[index]; end
  def full; %w{obese trivial homicidal rich}[index]; end
  def overwhelmed; %w{sick afraid ashamed angry}[index]; end
  def exhausted; %w{sore stupid incoherent indebted}[index]; end

end
