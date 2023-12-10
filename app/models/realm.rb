class Realm < Concept

  def initialize(string); @symbol = string; end
  attr_reader :symbol

  def path; Rails.application.routes.url_helpers.realm_path(self.symbol); end

  ########
  SYMBOLS = %w{S N F T}
  ALL = SYMBOLS.collect {|symbol| self.new symbol}
  SYMBOLS.each_with_index{|s, i| define_singleton_method(s) {ALL[i]}}
  ########

  def behaviors; Behavior.select{|b| b.realm == self}; end
  def +(phase); behaviors.find{|b| b.phase == phase}; end

  def word; Words.realms[symbol]; end
  def adverb; word.ly ; end

  def resource; Words.resource[symbol]; end
  def resources; resource.pluralize; end

  def other_resources; Words.other_resources[symbol]; end

  def accept; Words.accept[symbol]; end
  def notice; Words.notice[symbol]; end
  def good; Words.good[symbol]; end
  def bad; Words.bad[symbol]; end

end
