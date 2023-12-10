class Phase < Concept

  def initialize(string); @symbol = string; end
  attr_reader :symbol

  def path; Rails.application.routes.url_helpers.realm_path(self.symbol); end

  ########
  SYMBOLS = %w{J I P E}
  ALL = SYMBOLS.collect {|symbol| self.new symbol}
  SYMBOLS.each_with_index{|s, i| define_singleton_method(s) {ALL[i]}}
  ########

  def behaviors; Behavior.select{|b| b.realm == self}; end
  def +(phase); behaviors.find{|b| b.phase == phase}; end

  def word; Words.phases[symbol]; end
  def description; Words.description[symbol].html_safe; end

  def precursor; Words.precursor[symbol]; end

end
