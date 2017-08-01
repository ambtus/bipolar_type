class Subtype

  def initialize(array)
    @pair = array
    @realm = array.first
    @attitude = array.second
  end
  attr_reader :realm, :attitude

  ALL = Realm::ALL.collect do |realm|
               Attitude::ALL.collect do |attitude|
                  self.new [realm,attitude]
                end
            end.flatten

  def self.all; ALL; end

  def method_missing(meth, *arguments, &block)
    if realm.respond_to?(meth)
      realm.send(meth, *arguments, &block)
    elsif attitude.respond_to?(meth)
      attitude.send(meth, *arguments, &block)
    else
      super
    end
  end

  def mbti; [@attitude.first, @realm.mbti, @attitude.second].join; end
  def inspect; mbti; end
  def path; mbti; end
  def symbol; path.upcase; end

  ALL.each{|s| define_singleton_method(s.path) {s}}
  def self.paths; ALL.map(&:path); end

  def description; [@attitude.description, @realm.description, "energy"].join(" "); end
  def name; description.titleize; end

  def siblings; (Subtype.all.select{|s| s.realm == @realm || s.attitude == @attitude}) - [self]; end

  def types; Type.all.select{|t| t.subtypes.include? self}; end

end
