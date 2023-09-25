class Type

  def self.my_path; "PAFM"; end
  def self.my_type; self.new my_path; end

  def initialize(string)
    @symbol = string
    @realms = string.scan(/./).collect{|x| Realm.send(x)}
    @realms.check_constraints Realm, 4, 4
  end
  attr_reader :symbol, :realms

  ALL = Realm::SYMBOLS.permutation(4).collect{|x| new(x.join)}

  def behaviors; realms.add(GenericBehavior.all); end

  GenericBehavior.each do |gb|
     define_method("#{gb.symbol.downcase}_behavior") {behaviors.find{|b| b.generic_behavior == gb}}
     define_method("#{gb.symbol.downcase}_realm") {behaviors.find{|b| b.generic_behavior == gb}.realm}
  end

  def name; realms.map(&:symbol).join; end
  def inspect; @symbol; end

end
