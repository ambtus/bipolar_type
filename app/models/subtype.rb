class Subtype
  LETTERS = Realm::LETTERS[1,4].multiply(%w{p j}).flatten

  def initialize(letters)
    raise "#{letters} isn't a Subtype" unless LETTERS.include?(letters)
    @index = LETTERS.index(letters)
    @path = letters
  end
  attr_reader :path

  SUBTYPES = LETTERS.collect{|letters| Subtype.new(letters)}
  def self.all; SUBTYPES; end
  def self.find(letters); SUBTYPES[LETTERS.index(letters)]; end

  def realm; Realm.find(path.first); end

  delegate :generic, :energy, :resources, to: :realm

  def p?; path.last == "p" ; end

  def result; p? ? realm.full : realm.empty ; end
  def goal; p? ? realm.empty : realm.full ; end
  def name; result.capitalize; end

  def put; p? ? "output" : "input"; end

  def putting; p? ? realm.output.ing : realm.input.ing; end
  def other_putting; p? ? realm.input.ing : realm.output.ing; end

  def change; p? ? "get rid of" : "gain"; end
  def other_change; p? ? "gain" : "get rid of"; end

  def pairs; realm.others.collect{|r| Pair.find(r.path + path)}; end

  def alt_end; p? ? "j" : "p"; end

  def alt_pairs; realm.others.collect{|r| Pair.find(path.first + r.path + alt_end)}; end

end
