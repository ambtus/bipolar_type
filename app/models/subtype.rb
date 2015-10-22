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

  def realm; Realm.find(path[2,1]); end
  def attitude; Attitude.find(path[0,2]); end
  def quads; Quad.all.select{|q| q.subtypes.include?(self)}; end

  LETTERS.each {|r| define_singleton_method(r) {find(r)}}

  def method_missing(method, *args, &block)
    if attitude.respond_to? method
      realm.gsub(attitude.send(method))
    elsif realm.respond_to? method
      realm.send(method, *args, &block)
   else
     super
   end
  end

  def name; short.titleize.squash; end

end
