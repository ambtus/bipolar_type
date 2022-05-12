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

  def energy; %w{calories facts love money}[index]; end

  def adjective; %w{physical mental social material}[index]; end
  def adverb; adjective.ly; end
  def name; adjective.capitalize; end

  def given; %w{fed shown told ??}[index]; end
  def resources; %w{food information stories ??}[index]; end

  def get; %w{eat watch listen sell}[index]; end
  def get_preposition; [nil, "the", "to", nil][index]; end
  def get_verb; [get, get_preposition].to_phrase; end

  def now_targets; %w{breakfast actions encouragement goods}[index]; end
  def get_now; [get, get_preposition, now_targets].to_phrase; end

  def later_targets; %w{dinner results praise services}[index]; end
  def get_later; [get, get_preposition, later_targets].to_phrase; end


  def use; %w{move think talk buy}[index]; end

  def taken; %w{led given asked sold}[index]; end
  def nouns; %w{places problems questions things}[index]; end
  def thing; %w{where thing one thing}[index]; end

  def use_verb; %w{go decide ask buy}[index]; end
  def use_preposition; [nil, "how to", nil, nil][index]; end

  def now_goals; %w{out start permission goods}[index]; end
  def use_now; [use_verb, use_preposition, now_goals].to_phrase; end

  def later_goals; %w{home finish forgiveness services}[index]; end
  def use_later; [use_verb, use_preposition, later_goals].to_phrase; end

  def get_and_use_now; [get_now, use_now].and; end
  def get_and_use_later; [use_later, get_later].and; end
end
