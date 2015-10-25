class Subtype
  LETTERS = Realm::LETTERS[1,4].multiply(Attitude::LETTERS[1,4]).flatten

  def self.ordered
    [0,1,4,5,
     2,3,6,7,
     8,9,12,13,
     10,11,14,15]
  end

  def initialize(letters)
    raise "#{letters} isn't a Subtype" unless LETTERS.include?(letters)
    @index = LETTERS.index(letters)
    @path = letters
  end
  attr_reader :path

  SUBTYPES = LETTERS.collect{|letters| Subtype.new(letters)}
  def self.all; SUBTYPES.values_at(*ordered); end
  def self.find(letters); SUBTYPES[LETTERS.index(letters)]; end

  def realm; Realm.find(path[0,1]); end
  def attitude; Attitude.find(path[1,2]); end
  def quads; Quad.all.select{|q| q.subtypes.include?(self)}; end

  def tla; [attitude.path.first,realm.path,attitude.path.second].join.upcase; end

  def short; [attitude.sensitivity,realm.sensory,attitude.preference].join(" "); end

  def name; short.titleize.squash; end

  def advice; [alternative, reaction.ing].join(" "); end

  def result
    case attitude.how_much
    when "lots of"
      "lots of #{energy}"
    when "relatively little"
      "relatively #{energy.few}"
    end
  end

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

end
