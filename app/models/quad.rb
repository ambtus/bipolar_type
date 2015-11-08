# Encoding: utf-8
class Quad
  def self.first_path; "i" + Realm::LETTERS.join; end
  def self.first; Quad.find(first_path); end

  LETTERS = Sensitivity::LETTERS.multiply(Realm::LETTERS.permutation(4).map(&:join)).flatten

  def initialize(letters)
    @path = letters
    @index = LETTERS.index(letters)
  end
  attr_reader :path

  QUADS = LETTERS.collect{|letters| Quad.new(letters)}
  def self.find(letters); QUADS[LETTERS.index(letters)]; end
  def self.all; QUADS; end

  def attitude; path.first; end
  def i?; attitude == "i"; end

  def realms_path; @path.chip; end

  def invert_path; i? ? "e" : "i"; end
  def invert; Quad.find(invert_path + realms_path); end

  def realms; realms_path.scan(/./).collect{|p| Realm.find(p)}; end

  def attitudes; i? ? %w{i e i e} :  %w{e i e i}; end
  def priorities; attitudes.each_with_index.collect {|s,i| realms[i] + Sensitivity.send(s)}; end
  def insensitive_priorities; priorities.select{|p| !p.i?}; end
  def sensitive_priorities; priorities.select{|p| p.i?}; end


  def controlled; Pair.new(priorities[0,2]); end
  def uncontrolled; Pair.new(priorities[2,2], false); end
  def euthymic_pairs; [controlled, uncontrolled];end
  def depressed_pairs; [Pair.new([sensitive_priorities.second, sensitive_priorities.first.invert]),  Pair.new(insensitive_priorities.reverse,false)] ; end
  def manic_pairs; [Pair.new([insensitive_priorities.second,insensitive_priorities.first.invert]), Pair.new(sensitive_priorities.reverse,false)] ; end

  delegate :mbtiish, :names, to: :controlled, prefix: true
  delegate :mbtiish, :names, to: :uncontrolled, prefix: true

  def dominant; controlled.first ; end
  def auxiliary; controlled.second ; end
  def tertiary; uncontrolled.first ; end
  def inferior; uncontrolled.second ; end

  %w{euthymic manic depressed}.each do |state|
    define_method(state + "_functions") {self.send(state + "_pairs").map(&:function).to_word("")}
    define_method(state + "_names") {self.send(state + "_pairs").map(&:names).to_word(" / ")}
  end

  alias_method :functions, :euthymic_functions
  alias_method :name, :euthymic_functions

  alias_method :names, :euthymic_names


  def priority_functions; priorities.map(&:function); end
  def euthymic_mbtis
    if controlled_mbtiish.is_mbti?
      [controlled_mbtiish]
    else
      [priority_functions.first.wrap(priority_functions.fourth), priority_functions.second.wrap(priority_functions.third)].collect{|m| m.fix(path.first)}
    end
  end

  def simple_mbti(pair,alternative)
    if pair.mbtiish.is_mbti?
      pair.mbtiish
    else
      pair.first.function.wrap(alternate)
    end.fix(path.first)
  end


  def depressed_mbtis; [simple_mbti(depressed_pairs.first,depressed_pairs.second.first)]; end

  def manic_mbtis; [simple_mbti(manic_pairs.first,manic_pairs.second.first)]; end

end
