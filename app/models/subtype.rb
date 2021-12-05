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

  def symbol
    @pair.map(&:symbol).join.chars.values_at(1,0,2).join
  end
  def path; symbol.downcase; end
  def inspect; symbol; end


  ALL.each{|s| define_singleton_method(s.path) {s}}
  def self.paths; ALL.map(&:path); end

  def siblings; attitude.subtypes + realm.subtypes - [self]; end
  def opposite; @realm + @attitude.opposite; end
  def previous; @realm + @attitude.previous; end
  def subsequent; @realm + @attitude.subsequent; end

  def types; Type.all.select{|t| t.subtypes.include?(self)}; end

  def answer_path; Answer.first.next(self); end


  def description
    case attitude.path
    when "ul"
      "often #{realm.intake} too much, sometimes #{realm.play} a lot"
    when "ll"
      "sometimes #{realm.play} a lot, never #{realm.attend} too much"
    when "ur"
      "often #{realm.work} too much, sometimes #{realm.intake} a lot"
    when "lr"
      "sometimes #{realm.attend} a lot, never #{realm.work} too much"
    end
  end
end
