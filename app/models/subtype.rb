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

  def tla = [attitude.first_letter, realm.letter, attitude.second_letter].join
  def self.find_by(hash) = ALL.find { |s| s.tla == hash[:tla].to_s }

  def self.without(string)
    subtypes = string.scan(/.../).collect { |tla| Subtype.find_by(tla: tla) }
    Rails.logger.debug { "subtypes: #{subtypes}" }
    realms = subtypes.map(&:realm)
    attitudes = subtypes.map(&:attitude)
    Subtype.all.reject { |s| realms.include?(s.realm) || attitudes.include?(s.attitude) }
  end

  def do_something = [attitude.gu, realm.adjective, attitude.es].to_phrase
  def episode = [realm.adverb, attitude.feeling].to_phrase

  def opposite = realm + attitude.opposite
  def flip = realm + attitude.flip
  def flop = realm + attitude.flop

  def feeling = [realm.adj1.ly, attitude.feeling].to_phrase
  def size = [realm.adverb, attitude.size].to_phrase

  def lines = File.foreach("app/views/words/_#{string}", chomp: true)

  delegate :time, to: :attitude
  delegate :top?, to: :attitude
  delegate :left?, to: :attitude
end
