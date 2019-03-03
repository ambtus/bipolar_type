class Realm < Concept

  SYMBOLS = %w{F S T N}

  ########
  ALL = SYMBOLS.collect {|symbol| self.new symbol}
  PATHS.each do |path|
    define_singleton_method(path) {ALL[PATHS.index(path)]}
  end
  ########

  SYMBOLS.each do |symbol|
    define_singleton_method(symbol.downcase) {ALL[SYMBOLS.index(symbol)]}
  end

  def subtypes; Subtype.all.select{|s| s.realm == self}; end
  def +(attitude); subtypes.find{|s| s.attitude == attitude}; end

  def adjective; %w{spiritual physical material mental}[index]; end
  def adjective; %w{affective physical financial mental}[index]; end
  def adverb; "#{adjective}ly"; end

  def neuro; %w{oxytocin serotonin dopamine norepinephrine}[index]; end

  def energy; %w{affect glucose currency data}[index]; end
  def reserves; %w{moods fat savings knowledge}[index]; end
  def strengths; %w{words muscles credit mental\ models}[index]; end

  ### INPUT
  def input; %w{listen\ to eat collect look\ for}[index]; end
  def basic_input; %w{praise protein your\ stipend commonalities}[index]; end
  def painful_input; %w{criticism sweets rewards exceptions}[index]; end

  def harvest; %w{hear smell touch see}[index]; end
  def process; %w{care\ about digest use believe}[index]; end
  def resources; %w{opinions food tools facts}[index]; end

  def input_pain; %w{suicidal nauseated angry afraid}[index]; end


  ### OUTPUT
  def output; %w{tell go buy plan\ for}[index]; end
  def basic_output; %w{yourself home necessities probabilities}[index]; end
  def harder; %w{heterogenous farther more\ expensive more\ unlikely}[index]; end
  def painful_output; %w{crowds away luxuries possibilities}[index]; end

  def achieve; %w{influence travel own envision}[index]; end
  def goals; %w{people places things ideas}[index]; end

  def output_pain; %w{misunderstood sore indebted stupid}[index]; end

  def question; %w{who where what why}[index]; end
  def thing; %w{one where thing thing}[index]; end
  def them; %w{them there them them}[index]; end


end


# N output words
# steady: synthesis. compare. analogy. similarities. spatial. put together. decide
# extra: analyze. contrast. logic (nor). differences. linear. split apart. choose

# F output words
# steady: expressive. intonation. music. sing. emotional. whine. emoticons
# extra: lexical. words. lyrics. write. meaningful. explain. letters
