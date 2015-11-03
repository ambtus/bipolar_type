class Subtype
  LETTERS = Attitude::LETTERS.multiply(Realm::LETTERS[1,4]).flatten

  def initialize(letters)
    raise "#{letters} isn't a Subtype" unless LETTERS.include?(letters)
    @index = LETTERS.index(letters)
    @path = letters
  end
  attr_reader :path

  SUBTYPES = LETTERS.collect{|letters| Subtype.new(letters)}
  def self.all; SUBTYPES; end
  def self.find(letters); SUBTYPES[LETTERS.index(letters)]; end

  def <=>(other_subtype); realm.path <=> other_subtype.realm.path; end

  def realm; Realm.find(path[1,2]); end
  def attitude; Attitude.find(path.first); end

  def opposite; Subtype.find(attitude.opposite.path + realm.path); end

  delegate :behavior, :behavior2, :normalize, :recover, to: :attitude

  %w{tendency goal short short2 behave behave2}.each {|m| define_method(m) { realm.send(attitude.send(m)) }}

  def name; tendency.capitalize; end

  def paths; realm.others.map(&:path).add(self.path); end
  def outputs; paths.collect{|p| Pair.find("i" + p)}; end
  def inputs; paths.collect{|p| Pair.find("e" + p)}; end

  def method_missing(meth)
    if realm.respond_to?(meth)
      realm.send(meth)
    else
      super
    end
  end
end
