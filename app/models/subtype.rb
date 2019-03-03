class Subtype

  def initialize(pair)
    @pair = pair
    @realm = pair.first
    @attitude = pair.second
  end
  attr_reader :realm, :attitude

  ALL = Realm::ALL.collect do |realm|
          Attitude::ALL.collect do | attitude |
            self.new [realm,attitude]
          end
        end.flatten

  def self.all; ALL; end
  def self.first; ALL.first; end

  def method_missing(meth, *arguments, &block)
    if realm.respond_to?(meth)
      realm.send(meth, *arguments, &block)
    elsif attitude.respond_to?(meth)
      attitude.send(meth, *arguments, &block)
    else
      super
    end
  end

  def <=>(other); attitude.index <=> other.attitude.index; end

  def path; @pair.map(&:path).join; end
  def symbol; @attitude.symbol.first + @realm.symbol + @attitude.symbol.second; end
  def inspect; symbol; end

  def name; @pair.map(&:name).join("ly "); end

  ALL.each{|s| define_singleton_method(s.path) {s}}
  def self.paths; ALL.map(&:path); end

  def siblings; attitude.subtypes + realm.subtypes - [self]; end

  def same_attitude; @attitude.subtypes - [self]; end

  def opposite; @realm + @attitude.opposite; end

  def types; Type.all.select{|t| t.subtypes.include?(self)}; end

  def answer_path; Answer.first.next(self); end

  def bad; @realm.send("#{@attitude.stimulus}_pain"); end
  def opposite_pain; @realm.send("#{@attitude.opposite_stimulus}_pain"); end

  def behave; @realm.send(@attitude.behavior); end

  def done; behave.en; end
  def basics; @realm.send("basic_#{@attitude.stimulus}"); end

  def extras; @realm.send("painful_#{@attitude.stimulus}"); end

end
