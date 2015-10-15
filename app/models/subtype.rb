class Subtype
  LETTERS = Realm::LETTERS[1,4].multiply(Attitude::LETTERS).flatten

  def initialize(letters)
    raise "#{letters} isn't a Subtype" unless LETTERS.include?(letters)
    @index = LETTERS.index(letters)
    @path = letters
  end
  attr_reader :path

  SUBTYPES = LETTERS.collect{|letters| Subtype.new(letters)}
  def self.all; SUBTYPES; end
  def self.find(letters); SUBTYPES[LETTERS.index(letters)]; end

  def realm; Realm.find(path[0,1]); end
  def attitude; Attitude.find(path[1,2]); end
  def quads; Quad.all.select{|q| q.subtypes.include?(self)}; end

  LETTERS.each {|r| define_singleton_method(r) {find(r)}}

  delegate :first, :second, to: :attitude
  def method_missing(method, *args, &block); realm.send(method, *args, &block); end

  def name; [first, sensory, second].map(&:capitalize).join; end

end
