class Energy < Concept

  ADJECTIVES = %w{physical mental social financial}
  GETS = %w{eat watch listen earn}
  USES = %w{move think talk spend}
  MEASURES = %w{calories facts opinions assets}
  STORES = %w{fat memory friend savings}
  ########

  ACRONYMS = ADJECTIVES.map(&:first)
  ALL = ACRONYMS.collect {|letter| self.new letter}
  ACRONYMS.each do |letter|
    define_singleton_method(letter) {ALL[ACRONYMS.index(letter)]}
  end
  ########

  def subtypes; Subtype.all.select{|s| s.energy == self}; end
  def +(imbalance); subtypes.find{|s| s.imbalance == imbalance}; end

  def adjective; ADJECTIVES[index]; end
  def name; adjective.capitalize; end
  def symbol; path.upcase; end

  def get; GETS[index]; end
  def use; USES[index]; end
  def measure; MEASURES[index]; end
  def store; STORES[index]; end

  def using; use.gsub(/e$/, '') + 'ing'; end
  def getting; get.gsub(/e$/, '') + 'ing'; end

end
