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

  def appears; %w{smells looks sounds feels}[index]; end

  def notice; %w{smell see hear touch}[index]; end
  def attend; %w{taste watch listen take}[index]; end
  def intake; %w{eat learn understand collect}[index]; end
  def get; [notice, attend, intake].join("/"); end

  def output; %w{move imagine care pay}[index]; end
  def play; %w{walk predict talk buy}[index]; end
  def work; %w{labor plan write own}[index]; end
  def use; [output, play, work].join("/"); end

  def energy; %w{glucose facts emotions money}[index]; end

  def adjective; %w{physical mental social financial}[index]; end
  def name; adjective.capitalize; end

  def reserves; %w{fat knowledge ego savings}[index]; end
  def much; reserves.much; end
  def little; reserves.little; end


end
