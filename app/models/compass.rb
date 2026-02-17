# frozen_string_literal: true

class Compass < Concept
  SYMBOLS = %i[i f p x e c j r].freeze
  ALL = SYMBOLS.collect { |symbol| new symbol }

  SYMBOLS.each do |sym|
    define_singleton_method(sym) { ALL.find { |s| s.symbol == sym } }
  end

  def self.behaviors = ALL.select{|x| x.index.odd?}

  def name = { f: 'fuel the self', x: 'explore the other', c: 'control the other', r: 'rest the self', i: 'the self', p: 'play', e: 'the other', j: 'work'}[symbol]
  def short = name.words.first

  def adjective = { f: :dysphoric, r: :bored, x: :anxious, c: :irritable}[symbol].to_s

end
