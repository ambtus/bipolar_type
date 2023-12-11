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
  def name; "#{receptive.accept_things} while #{calming.accept_things.ing} and #{productive.change_things} while #{revving.change_things.ing}"; end

  def receptive; realms.first; end
  def calming; realms.second; end
  def productive; realms.third; end
  def revving; realms.fourth; end

  def goal; "Your goals are to #{receptive.accept} the #{receptive.things} that you need to #{receptive.accept} and #{productive.change} the #{productive.things} you need to #{productive.change}. #{calming.accept_things.ing.capitalize} is easy and calms you down enough to #{receptive.accept_things} and #{revving.change_things.ing} is easy and revs you up enough to #{productive.change_things}.".html_safe; end


end

