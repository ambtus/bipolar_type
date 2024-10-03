class Function

  SYMBOL = %w{F S T N}
  NAME = %w{people places things ideas}
  CENTER = %w{soul body hands mind}
  CENTER2 = %w{heart stomach wallet head}
  ORGAN = %w{ears mouth skin eyes}

  ADJECTIVE = %w{spiritual physical material mental}
  ADJ2 = %w{affective caloric financial cognitive}

  TRIGGERS = %w{sounds smells touches sights}

  HALLUCINATIONS = %w{auditory olfactory tactile visual}

  INTERNALIZE = %w{listen eat sell watch}
  GET = %w{hear smell touch see}
  INTAKE = %w{understand digest collect remember}

  EXTERNALIZE = %w{talk move buy think}
  OUTPUT = %w{communicate exercise spend plan}
  GIVE = %w{speak walk pay decide}

  RESERVES = %w{self\ esteem fat money reality}
  DEATH = %w{suicidal anorexic destitute insane}

  CSS = %w{red cyan green violet}

  def initialize(symbol); @symbol = symbol; end
  attr_reader :symbol
  alias path :symbol
  alias inspect :symbol

  ALL = SYMBOL.collect {|symbol| self.new symbol}
  SYMBOL.each_with_index do |symbol, index|
    define_singleton_method(symbol) {ALL[index]}
    define_singleton_method(symbol.downcase) {ALL[index]}
  end
  def index; SYMBOL.index @symbol; end
  def <=>(other); self.index <=> other.index; end

  class << self
    def all; ALL; end
    def each(&block); ALL.each(&block); end
    def without_physical; ALL.without(self.s); end
    def cookies; ALL.map(&:cookies).flatten; end
    def visible; %i{ADJECTIVE ADJ2 TRIGGERS HALLUCINATIONS CENTER2 CENTER ORGAN GET INTAKE GIVE OUTPUT RESERVES DEATH}; end
  end

  def cookies; %w{e i}.collect{|key| symbol + key}; end

  def flip; self; end
  def flop; self; end
  def opposite; flip.flop; end

  constants.each do |constant|
    define_method(constant.downcase) {self.class.const_get(constant)[index]}
  end
  cookies.each do |cookie|
    define_singleton_method(cookie) {
      function = self.send(cookie.first)
      cookie.second == 'i' ? function.internalize : function.externalize
    }
  end

  def adverb; adjective.ly; end

  def lose_reserves; ['lose', reserves].to_phrase; end
  def gain_reserves; ['gain', reserves].to_phrase; end
  def run_out; ['run out of', reserves].to_phrase; end

  alias nouns :name
  alias e :externalize
  alias i :internalize

end
