# frozen_string_literal: true

class Subtype < Concept
  SYMBOLS = Realm.all.collect do |realm|
    Attitude.all.collect do |attitude|
      (attitude.string.first + realm.string + attitude.string.second).to_sym
    end
  end.flatten

  ALL = SYMBOLS.collect { |symbol| new symbol }

  def realm = Realm.find(string.second)
  def attitude = Attitude.find(string.first + string.third)

  def tla = [first_letter, realm.letter, second_letter].join
  def self.find_by(h = {}) = ALL.find { |s| s.tla == h[:tla].to_s }

  def meth = [gu, es].join('_')
  def action = realm.send(meth)

  # sort by attitude
  def parts = [attitude, realm]
  def next = realm + attitude.next
  def previous = realm + attitude.previous
  def opposite = realm + attitude.opposite
  def flip = realm + attitude.flip
  def flop = realm + attitude.flop

  def next_realm = realm.next + attitude

  def method_missing(meth)
    if attitude.respond_to?(meth)
      attitude.send(meth)
    elsif realm.respond_to?(meth)
      realm.send(meth)
    else
      super
    end
  end
end
