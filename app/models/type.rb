class Type < Concept

  def self.my_path; 'FSNT' ; end
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
  def subtypes; realms.add(Problem.all); end
  def mbti; "#{realms.first.p_symbol}#{realms.first.symbol}Pw/#{realms.second.symbol}•#{realms.third.j_symbol}#{realms.third.symbol}Jw/#{realms.fourth.symbol}"; end
  def under; "#{receptive.accept_things} and #{productive.change_things}"; end
  def over; "#{submissive.accept_things} and #{dominant.change_things}"; end
  def name; ['Under: ' + under, 'Over: ' + over].join('<br />').html_safe; end

  def receptive; realms.first; end
  def submissive; realms.second; end
  def productive; realms.third; end
  def dominant; realms.fourth; end

  def goal; "Your goals are to #{receptive.accept} the #{receptive.things} that you want to #{receptive.accept} and #{productive.change} the #{productive.things} you want to #{productive.change} without over-#{submissive.accept_things.ing} and over-#{dominant.change_things.ing}.".html_safe; end


end

