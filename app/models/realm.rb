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

  def mbti; symbol; end

  def subtypes; Subtype.all.select{|s| s.realm == self}; end
  def +(attitude); subtypes.find{|s| s.attitude == attitude}; end


  def attend; %w{drink watch listen take}[index]; end
  def get; %w{eat learn care sell}[index]; end
  def resources; %w{foods lessons voices tools}[index]; end
  def appear; %w{tastes look sound feel}[index]; end

  def stimulants; %w{carbs exceptions music rewards}[index]; end
  def strengtheners; %w{protein rules words investment\ income}[index]; end

  def use; %w{walk think talk buy}[index]; end
  def change; %w{go plan tell build}[index]; end
  def things; %w{places events people things}[index]; end
  def thing; %w{where thing one thing}[index]; end
  def work; [change, things].to_phrase; end

  def play; %w{dance daydream sing splurge}[index]; end
  def stress; %w{pace worry cry shop}[index]; end

  def empty; %w{hungry unsure lonely overdrawn}[index]; end

  def energy; %w{calories facts love money}[index]; end
  def name; energy.capitalize; end

  def adjective; %w{physical mental social financial}[index]; end
  def adverb; adjective.ly; end

  def potential; %w{fat knowledge love savings}[index]; end
  def reserves; %w{body head heart bank}[index]; end

  def bad; %w{sick afraid suicidal angry}[index]; end

end
