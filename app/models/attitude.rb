# frozen_string_literal: true

class Attitude < Concept
  SYMBOLS = %i[i f p x e c j r].freeze
  ALL = SYMBOLS.collect { |symbol| new symbol }

  SYMBOLS.each do |sym|
    define_singleton_method(sym) { ALL.find { |s| s.symbol == sym } }
  end

  def self.behaviors = ALL.select{|x| x.index.odd?}
  def self.permutations = [
    [Attitude.f, Attitude.x, Attitude.r, Attitude.c],
    [Attitude.x, Attitude.f, Attitude.c, Attitude.r],
    [Attitude.r, Attitude.c, Attitude.f, Attitude.x],
    [Attitude.c, Attitude.r, Attitude.x, Attitude.f]
  ]
  def self.mine = [Attitude.f, Attitude.x, Attitude.r, Attitude.c]

  def name = { f: 'digest', x: 'flight', c: 'fight', r: 'rest', i: 'winter', p: 'spring', e: 'summer', j: 'autumn'}[symbol]


end
