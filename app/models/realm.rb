class Realm < Concept

  SYMBOLS = %w{S N T F}
  ########
  ALL = SYMBOLS.collect {|symbol| self.new symbol}
  SYMBOLS.each do |path|
    define_singleton_method(path) {ALL[SYMBOLS.index(path)]}
  end
  ########

  def subtypes; Subtype.all.select{|s| s.realm == self}; end
  def +(attitude); subtypes.find{|s| s.attitude == attitude}; end

  def pursue; %w{buy  take ask go}[index]; end
  def nouns; %w{things  actions people places}[index]; end

  def adjective; %w{financial  mental affective physical}[index]; end
  def name; adjective.titleize; end

  def energy; %w{money information emotions calories}[index]; end

  def notice; %w{touch  see hear smell/taste}[index]; end
  def get; %w{use  believe understand eat}[index]; end
  def process; %w{make  replicate verbalize cook}[index]; end
  def resources; %w{tools  effects opinions foods}[index]; end

  def gettable; %w{useable  believable understandable edible}[index]; end

end
