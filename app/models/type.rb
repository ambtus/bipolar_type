class Type < Concept

  def self.my_path; 'TFNS' ; end
  def self.my_type; self.new my_path; end

  def path; Rails.application.routes.url_helpers.type_path(self.symbol); end

  def initialize(string)
    @symbol = string
    @realms = string.chars[0,4].collect{|x| Realm.send(x)}
    @realms.check_constraints Realm, 4, 4
  end
  attr_reader :symbol, :realms

  ########
  ALL = Realm::SYMBOLS.permutation(4).collect{|x| new(x.join)}
  SYMBOLS = ALL.map(&:symbol)
  SYMBOLS.each {|s| define_singleton_method(s) {ALL[SYMBOLS.index(s)]}}
  ########

  def inspect; @symbol; end
  def name; realms.map(&:name).map(&:first).join; end

  def revving; realms.first; end
  def receptive; realms.second; end
  def productive; realms.third; end
  def calming; realms.fourth; end

  def goal; "Your goal is to be Productive enough to be able to #{productive.change} the #{productive.things} you need to #{productive.change}, but not so Manic that you #{revving.change} too many #{revving.things} that do <em>not</em> need to be #{revving.change.en}; Receptive enough to be able to #{receptive.accept} the #{receptive.things} that you need to #{receptive.accept}, but not so Depressed that you #{calming.accept} too many #{calming.things} that you should <em>not</em> be #{calming.accept.ing}.".html_safe; end


end

