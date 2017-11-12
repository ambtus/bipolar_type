class Subtype

  def initialize(array)
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

  def path; [@attitude.first, @realm.path, @attitude.second].join; end
  def inspect; path; end
  def mbti; path.upcase; end

  ALL.each{|s| define_singleton_method(s.path) {s}}
  def self.paths; ALL.map(&:path); end

  def siblings; attitude.subtypes + realm.subtypes - [self]; end

  def name; [@realm.name, @attitude.name].join(" "); end

end
