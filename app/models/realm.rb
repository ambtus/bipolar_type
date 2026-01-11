# frozen_string_literal: true

class Realm < Concept
  SYMBOLS = %i[S N F T].freeze
  ALL = SYMBOLS.collect { |symbol| new symbol }
  SYMBOLS.each do |sym|
    define_singleton_method(sym) { ALL.find { |s| s.symbol == sym } }
  end

  def behaviors = Behavior.all.select { |x| x.realm == self }
  def subtypes = Subtype.all.select { |x| x.realm == self }

  def +(other)
    return behaviors.find { |x| x.action == other } if other.is_a? Action

    subtypes.find { |x| x.mood == other }
  end

  def self.measurable = [self.S, self.T]
  def self.unmeasurable = [self.N, self.F]

  def realm = %w[physical mental social financial][index]
  def sense = %w[smell/taste sight hearing touch][index]
  def signal = %w[scents light sounds heat][index]
  def jungian = %w[Sensing iNtuition Feeling Thinking][index]
  def focus = %w[food truth love shelter][index]
  def adverb = %w[where how why what][index]
  def my = %w[body mind soul credit][index]
  def intake = %w[eat watch listen earn][index]
  def prep = ['in', '', 'to', 'from'][index]
  def intake_with = [intake, prep].to_phrase
  def resources = %w[food information people tools][index]
  def them = resources.them
  def attend = ['eat', 'remember', 'listen to', 'use'][index]
  def deal_with = ['cook', 'use', 'talk to', 'build'][index]
  def intaken = %w[eaten seen heard collected][index]
  def externals = %w[places ideas people things][index]
  def output = %w[walk think talk buy][index]
  def energy = %w[calories facts emotions cash][index]
  def ip = ['eat carbs', 'analyze facts', 'listen to music', 'earn cash'][index]
  def ep = ['run marathons', 'synthesize facts', 'express emotions', 'spend cash'][index]
  def strength = %w[muscles logic language credit][index]
  def ej = "use #{strength}"
  def ij = ['eat protein', 'watch the results', 'listen to feedback', 'collect ROI'][index]

  def healthy = %w[nutritious true good valuable][index]
  def unhealthy = %w[poisonous false bad worthless][index]

  def self.pp_order = ALL.values_at(2, 0, 3, 1)
  def self.focus_order = ALL.values_at(0, 3, 1, 2)
end
