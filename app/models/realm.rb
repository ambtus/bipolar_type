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

  def thing; Words.thing[symbol]; end
  def things; thing.pluralize; end

  def other_things; Words.other_things[symbol]; end

  def change; Words.change[symbol]; end
  def accept; Words.accept[symbol]; end
  def acceptable; Words.acceptable[symbol]; end
  def unacceptable; Words.unacceptable[symbol]; end
  def notice; Words.notice[symbol]; end
  def appear; Words.appear[symbol]; end
  def good; Words.good[symbol]; end
  def bad; Words.bad[symbol]; end

  def change_things;[change, things].to_phrase; end

  def accept_things;[accept, things].to_phrase; end

end
