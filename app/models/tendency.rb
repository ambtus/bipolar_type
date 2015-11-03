class Tendency
  LETTERS = Realm::LETTERS.multiply(Attitude::LETTERS).flatten

  def initialize(letters)
    raise "#{letters} isn't a Tendency" unless LETTERS.include?(letters)
    @index = LETTERS.index(letters)
    @path = letters
  end
  attr_reader :path

  TENDENCIES = LETTERS.collect{|letters| Tendency.new(letters)}
  def self.all; TENDENCIES; end
  def self.find(letters); TENDENCIES[LETTERS.index(letters)]; end

  def self.find_by(nature); all.find{|t| t.nature == nature}; end

  def +(sensitivity); Subtype.find(sensitivity.path + self.path); end
  def subtypes; Sensitivity.all.add(self); end

  def realm; Realm.find(path.first); end
  def attitude; Attitude.find(path.second); end

  def opposite; Tendency.find(realm.path + attitude.opposite.path); end

  def method_missing(meth)
    if attitude.respond_to?(meth)
      realm.send(attitude.send(meth))
    elsif realm.respond_to?(meth)
      realm.send(meth)
    else
      super
    end
  end

  def natural_level; attitude.tendency; end
  def nature; tendency; end
  def name; nature.capitalize; end

  def oversensitive_subtype; Subtype.find("i" + path); end
  def insensitive_subtype; Subtype.find("e" + path); end

  def oversensitive_pairs; oversensitive_subtype.pairs ; end
  def insensitive_pairs; insensitive_subtype.pairs ; end

end
