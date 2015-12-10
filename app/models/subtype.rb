class Subtype < Phrase

  def initialize(array)
    @realm = array.first
    @attitude = array.second
    super
  end
  attr_reader :realm, :attitude

  def sort_order; [attitude, realm]; end
  def <=>(other); sort_order <=> other.sort_order; end

  ALL = Attitude::ALL.collect do |attitude|
          Realm::ALL.collect do |realm|
            self.new [realm,attitude]
          end
        end.flatten
  def self.all; ALL; end
  def word; attitude.first + realm + attitude.second; end
  def inspect; word; end
  def to_s; word.to_s; end
  def path; to_s.downcase; end
  ALL.each{|subtype| define_singleton_method(subtype.path) {subtype}}
  def self.paths; ALL.map(&:path); end

  def discover_path; Answer.first.next(self); end

  def same_realm; ALL.select{|s| s.realm == realm}; end
  def same_attitude; ALL.select{|s| s.attitude == attitude}; end

  def adjectives; [realm.adjective.ly, attitude.adjective]; end
  def adjective; Phrase.new adjectives ; end
  def name; Phrase.new [adjective.titleize, inspect.parenthesize]; end

  delegate :direction, :amount, :sensitivity, :ordinal, to: :attitude
  delegate :triggers, :buffers, :potentials, to: :realm

  def first_action; realm.send(attitude.first_action); end
  def first_lesson; Phrase.new [direction, first_action.ing]; end

  def second_action; realm.send(attitude.second_action); end
  def second_lesson; Phrase.new [direction, second_action.ing]; end

  def react; Phrase.new [Verb.new("feel"), realm.send(attitude.feeling)]; end 

  def how_many_potentials; attitude.how_many_potentials(potentials); end

end
