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


  def intake1; %w{eat watch listen work}[index]; end
  def intake2; %w{drink learn understand sell}[index]; end
  def get; [intake1, intake2].join("/"); end

  def output1; %w{walk think laugh buy}[index]; end
  def output2; %w{move imagine cry rent}[index]; end
  def use; [output1, output2].join("/"); end

  def energy; %w{calories information love money}[index]; end
  def much; energy.much; end
  def little; energy.little; end

  def adjective; %w{physical mental social financial}[index]; end
  def name; energy.capitalize; end

  def reserves; %w{fat memories ?? savings}[index]; end

  def hit; %w{go plan evaluate have}[index]; end
  def target; %w{place events person things}[index]; end
  def targets; target.pluralize; end
  def use_energy; [hit, targets].to_phrase; end

  def seek; %w{taste see hear use}[index]; end
  def resource; %w{food result opinion tool}[index]; end
  def resources; resource.pluralize; end
  def get_energy; [seek, resources].to_phrase; end

  def empty; %w{anorexic ignorant suicidal poor}[index]; end
  def full; %w{obese trivial homicidal rich}[index]; end
  def overwhelmed; %w{sick afraid ashamed angry}[index]; end
  def exhausted; %w{sore stupid incoherent indebted}[index]; end

end
