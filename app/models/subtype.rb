class Subtype < Phrase

  def initialize(array)
    @realm = array.first
    @nature = array.second
    super
  end
  attr_reader :realm, :nature

  ALL = Realm::ALL.collect do |realm|
               Nature::ALL.collect do |nature|
                  self.new [realm,nature]
                end
            end.flatten

  def self.all; ALL; end

  ALL.each{|s| define_singleton_method(s.path) {s}}
  def self.paths; ALL.map(&:path); end

  def peers; ALL.select{|s| s.realm == realm || s.nature == nature} - [self]; end
  def wings; ALL.select{|s| nature.wings.include? s.nature}; end
  def answer_path; Answer.first.next(self); end

  def <=>(other); [nature, realm] <=> [other.nature, other.realm]; end

  def method_missing(meth, *arguments, &block)
    if nature.respond_to?(meth)
      nature.send(meth, *arguments, &block)
    elsif realm.respond_to?(meth)
      realm.send(meth, *arguments, &block)
    else
      super
    end
  end

  def symbol; Word.new [kind, realm, action].map(&:symbol).join; end
  def generic; Phrase.new [kind, realm, action].map(&:generic); end

  def name; Phrase.new [generic.titleize, symbol.parenthesize]; end

  def short; Phrase.new [kind.generic, realm.send(action.generic)]; end
  def short_name; Phrase.new [short.titleize]; end
end
