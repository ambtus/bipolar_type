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

  def functions; priorities.map(&:function); end

  def dominant_subtypes; priorities[0,2]; end
  def secondary_subtypes; priorities[2,2]; end

  def dominant; dominant_subtypes.first ; end
  def auxiliary; dominant_subtypes.second ; end
  def tertiary; secondary_subtypes.first ; end
  def inferior; secondary_subtypes.second ; end


  def dominant_mbtiish; dominant.function.wrap(auxiliary.function); end
  def dominant_names; dominant_subtypes.map(&:name).to_word(" & "); end
  def dominant_full; ["Controlled", dominant_names].to_word; end
  def secondary_mbtiish; tertiary.function.wrap(inferior.function); end
  def secondary_names; secondary_subtypes.map(&:name).to_word(" & "); end
  def secondary_full; ["Uncontrolled", secondary_names].to_word; end
  def names; [dominant_full, secondary_full].to_word(" / "); end

  def swap; Quad.find(invert_path + realms_path[0,2] + realms_path[2,2].reverse); end

  %w{euthymic manic depressed}.each {|state| define_method(state + "_functions") {self.send(state + "_subtypes").map(&:function)}}

  def euthymic_subtypes; dominant_subtypes + secondary_subtypes; end
  def name; euthymic_functions.join; end
  def euthymic_mbtis
    first_try = euthymic_functions.first.wrap(euthymic_functions.second)
    if first_try.is_mbti?
      [first_try]
    else [functions.first.wrap(functions.third), functions.second.wrap(functions.fourth)]
    end.collect{|m| m.fix(path.first)}
  end

  def simple_mbti(functions)
    first_try = functions.first.wrap(functions.second)
    if first_try.is_mbti?
      first_try
    else functions.first.wrap(functions.third)
    end.fix(path.first)
  end

  def depressed_subtypes; ([priorities.first, priorities.second.invert] + priorities[2,2]); end
  def depressed_mbtis; [simple_mbti(depressed_functions)]; end

  def manic_subtypes; (priorities[0,2] + [priorities.third.invert, priorities.last]).reverse; end
  def manic_mbtis; [simple_mbti(manic_functions)]; end

end
