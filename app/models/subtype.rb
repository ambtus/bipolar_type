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
  def symbol; @pair.map(&:symbol).join; end
  def inspect; symbol; end

  def description; "#{realm.adjective} #{attitude.disorder}"; end
  def name; "#{description.titleize}"; end

  ALL.each{|s| define_singleton_method(s.path) {s}}
  def self.paths; ALL.map(&:path); end

  def siblings; attitude.subtypes + realm.subtypes - [self]; end

  def types; Type.all.select{|t| t.subtypes.include?(self)}; end

end
