class Subtype

  def initialize(realm, position)
    @realm = realm
    @position = position
  end
  attr_reader :realm, :position

   ALL = Position::ALL.collect do | position |
          Realm::ALL.collect do |realm|
            self.new(realm,position)
          end
        end.flatten

  class << self
    def find(string); ALL.find{|s| s.path == string}; end
    def select(realm, position); ALL.find{|s| s.realm == realm && s.position == position}; end
    def all; ALL; end
    def each(&block); ALL.each(&block); end
  end

  def method_missing(meth, *arguments, &block)
    if realm.respond_to?(meth)
      realm.send(meth, *arguments, &block)
    elsif position.respond_to?(meth)
      position.send(meth, *arguments, &block)
    else
      super
    end
  end

  def symbol; [@position.symbol.chars.first, @realm.symbol, @position.symbol.chars.second].join; end
  def path; symbol; end
  def inspect; symbol; end

  def solution
    case position
    when Position.first
      "listen to music"
    when Position.second
      @realm.strong_action
    when Position.third
      @realm.energetic_action
    when Position.fourth
      "close your eyes"
    else
      "TBD"
    end
  end

end
