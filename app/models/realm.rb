class Realm < Concept

  def initialize(string); @symbol = string; end
  attr_reader :symbol

  def path; Rails.application.routes.url_helpers.realm_path(self.symbol); end
  def nature_path; Rails.application.routes.url_helpers.nature_path(self.symbol); end

  ########
  SYMBOLS = %w{P M A F}
  ALL = SYMBOLS.collect {|symbol| self.new symbol}
  SYMBOLS.each{|s| define_singleton_method(s) {ALL[SYMBOLS.index(s)]}}
  ########

  def behaviors; Behavior.select{|b| b.realm == self}; end
  def +(phase); behaviors.find{|b| b.phase == phase}; end

  def word; %w{physical mental affective financial}[index]; end

end
