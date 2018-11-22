class Realm < Concept

  SYMBOLS = %w{F S T N}

  ########
  ALL = SYMBOLS.collect {|symbol| self.new symbol}
  PATHS.each do |path|
    define_singleton_method(path) {ALL[PATHS.index(path)]}
  end
  %w{first second third fourth}.each_with_index do |ordinal, index|
    define_singleton_method(ordinal) {ALL[index]}
  end
  ########

  def subtypes; Subtype.all.select{|s| s.realm == self}; end
  def +(attitude); subtypes.find{|s| s.attitude == attitude}; end


  def noun; %w{person place thing idea}[index]; end
  def nouns; noun.s; end
  def self.nouns; ALL.map(&:nouns); end

  def adjective; %w{verbal physical financial mental}[index]; end
  def adverb; adjective.ly; end
  def name; adverb.capitalize; end

  def hit; %w{criticize clean invest analyze}[index]; end
  def shove; %w{shame disinfect improve disprove}[index]; end
  def run; %w{apologize run discard disbelieve}[index]; end
  def hide; %w{deflect leave abandon forget}[index]; end

  def get; %w{listen\ to eat earn learn}[index]; end
  def strengtheners; %w{commentary protein wages logic}[index]; end
  def energizers; %w{music carbs investment\ income facts}[index]; end

  def organ; %w{relationships body finances brain}[index]; end
  def is; %w{are is are is}[index]; end

end
