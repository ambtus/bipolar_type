class Type

  def self.my_path; "AFMP"; end
  def self.my_type; self.new my_path; end

  def initialize(string)
    @symbol = string
    @realms = string.scan(/./).collect{|x| Realm.send(x)}
    @realms.check_constraints Realm, 4, 4
  end
  attr_reader :symbol, :realms

  ALL = Realm::SYMBOLS.permutation(4).collect{|x| new(x.join)}

  %w{A B C D}.each_with_index {|letter, i| define_method(letter) {@realms[i]}}

  def behaviors; realms.add(GenericBehavior.all); end

  def name; realms.map(&:symbol).join; end

  def inspect; @symbol; end

  def index_realm(index); @realms[(index+2)%4]; end
end
