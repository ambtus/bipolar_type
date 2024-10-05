class Function

  SYMBOL = %w{F S T N}
  NAME = %w{people places things ideas}

  ADJECTIVE = %w{affective physical financial mental}
  ADJECTIVE2 = %w{spiritual caloric material cognitive}

  HALLUCINATIONS = %w{auditory olfactory tactile visual}
  TRIGGERS = %w{sounds smells touches sights}
  SENSOR = %w{ears mouth skin eyes}
  GET = %w{hear smell touch see}
  INTERNALIZE = %w{listen eat earn watch}
  PROCESS = %w{understand digest collect remember}
  COMPILER = %w{heart stomach hands head}
  CENTER = %w{soul body wallet mind}

  EXTERNALIZE = %w{talk walk spend think}
  WORK = %w{preach labor invest plan}
  PLAY = %w{sing exercise splurge imagine}

  RESERVES = %w{self\ esteem fat money reality}
  DEATH = %w{suicidal anorexic destitute insane}

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
    def visible; constants.sort - %i{ALL NAME SYMBOL EXTERNALIZE INTERNALIZE}; end
  end

  def cookies; %w{J P}.collect{|key| symbol + key}; end

  def flip; self; end
  def flop; self; end
  def opposite; flip.flop; end

  constants.each do |constant|
    define_method(constant.downcase) {self.class.const_get(constant)[index]}
  end
  cookies.each do |cookie|
    define_singleton_method(cookie) {
      function = self.send(cookie.first)
      cookie.second == 'P' ? function.internalize : function.externalize
    }
  end

  alias nouns :name
  alias j :externalize
  alias p :internalize
  alias css :name

  def adverb; adjective.ly; end

  def lose_reserves; ['lose', reserves].to_phrase; end
  def gain_reserves; ['gain', reserves].to_phrase; end
  def run_out; ['run out of', reserves].to_phrase; end

end
