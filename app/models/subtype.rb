class Subtype
  LETTERS = Realm::LETTERS[1,4].multiply(Attitude::LETTERS.values_at(0,2,3,1)).flatten

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

  def high; 4 - attitude.index; end
  def emergency; "EMERGENCY" + "!" * high;end
  def low; attitude.index + 1; end
  def recovery; "WAIT" + "!" * low;end


  %w{nature nurture role result i_am goal should i_should advice}.each do |method|; define_method(method.to_sym) {realm.gsub(attitude.send(method))}; end

  def name; nature.s.split.map(&:capitalize).join; end

  alias_method :remember_your_should, :should
  alias_method :forget_your_role, :advice

  def method_missing(method, *args, &block); realm.send(method, *args, &block); end

end
