class Realm < Concept

  def initialize(string); @symbol = string; end
  attr_reader :symbol

  ########
  SYMBOLS = %w{S N F T}
  ALL = SYMBOLS.collect {|symbol| self.new symbol}
  SYMBOLS.each_with_index{|s, i| define_singleton_method(s) {ALL[i]}}
  ########

  def subtypes; Subtype.select{|x| x.realm == self}; end
  def +(problem); subtypes.find{|x| x.problem == problem}; end

  def thing; Words.thing[symbol]; end
  def things; thing.pluralize; end
  def word; Words.realms[symbol]; end
  def thing_s; %w{N F}.include?(symbol) ? thing : things; end

  def change; Words.change[symbol]; end
  def take; Words.take[symbol]; end
  def accept; Words.accept[symbol]; end
  def provide; Words.provide[symbol]; end

  def change_things;[change, things].to_phrase; end
  def accept_things;[take, 'and', accept, things].to_phrase; end
  def provide_thing;[provide, thing_s].to_phrase; end

  def notice; Words.notice[symbol]; end
  def emoticon; Words.emoticon[symbol]; end
  def appear; Words.appear[symbol]; end

  def acceptable; Words.acceptable[symbol]; end
  def unacceptable; Words.unacceptable[symbol]; end

  def gsub(string); string.gsub('The', 'There are many').
                           gsub('things', things).
                           gsub('accept', accept).
                           gsub('change', change); end

  def p_symbol; index < 2 ? 'E' : 'I'; end
  def j_symbol; index < 2 ? 'I' : 'E'; end
end
