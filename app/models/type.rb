class Type
  def self.my_path; "sffnst"; end
  def self.first; Type.find(my_path); end

  LETTERS = Quad.all.map(&:type_paths).flatten

  def initialize(letters)
    raise "#{letters} isn't a Type" unless LETTERS.include?(letters)
    @index = LETTERS.index(letters)
    @path = letters
  end
  attr_reader :path

  TYPES = LETTERS.collect{|letters| Type.new(letters)}
  def self.all; TYPES; end
  def self.find(letters); TYPES[LETTERS.index(letters)]; end

  def self.by_mbti; all.sort_by{|t| [t.mbti, t.theoretical_count]}; end

  def quad; Quad.find(path[2,4]); end
  def subtypes; quad.subtypes; end

  def dominant; subtypes.find{|s| s.realm.path == path.first}; end
  def auxiliary; subtypes.find{|s| s.realm.path == path[1]}; end
  def inferior; subtypes.find{|s| s.attitude == dominant.attitude.opposite}; end
  def tertiary; (subtypes - [dominant, auxiliary, inferior]).first; end

  def ordered_subtypes; [dominant, auxiliary, tertiary, inferior]; end

  def descriptions; ordered_subtypes.map(&:description); end
  def names; %w{Typical Usual Occasional Rare}.add(": ").add(ordered_subtypes.map(&:name)); end
  def actions; %w{always often sometimes rarely}.add(": ").add(ordered_subtypes.map(&:action)); end

  def mbtis; ordered_subtypes.map(&:mbti).join("–"); end
  def parentheticals; ordered_subtypes.map(&:mbti).map(&:parenthetical); end

  def partials; ordered_subtypes.map(&:path).map(&:mbti_order).join("–").upcase; end

  def try1; (dominant.path + auxiliary.realm.path).mbti_order; end
  def try2; (dominant.path + inferior.realm.path).mbti_order; end
  def mbti; try1.upcase.is_mbti? ? try1.upcase : try2.upcase ; end


  def test1; mbti.dominant != dominant.path.mbti_order.upcase; end
  def test2; subtypes.map(&:path).select{|m| m.mbti_order.upcase.is_theoretical?}.count == 2; end
  def test3; ! mbti.chars.include?(auxiliary.realm.path.upcase); end
  def test4; mbti.last != auxiliary.path.last.upcase; end

  def theoretical_count
    (test1 ? 6 : 0) +
    (test2 ? 1 : 0) +
    (test3 ? 1 : 0) +
    (test4 ? 3 : 0)
  end

  def method_missing(method, *args, &block)
    if method.to_s =~ /^(.*)_with_mbtis$/
      self.send($1, *args, &block).add(" ").add(parentheticals)
    else
      super
    end
  end

end

