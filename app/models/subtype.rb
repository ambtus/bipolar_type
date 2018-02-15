class Subtype

  def initialize(array)
    @realm = array.first
    @attitude = array.second
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

  def path; [@realm.path, @attitude.path].join; end
  def inspect; path; end
  def symbol; path.upcase; end

  ALL.each{|s| define_singleton_method(s.path) {s}}
  def self.paths; ALL.map(&:path); end

  def siblings; attitude.subtypes + realm.subtypes - [self]; end

  def transition
    case attitude.path
    when "a"
      "stop #{consuming}"
    when "b"
      "start #{producing}"
    when "c"
      "stop #{producing}"
    when "d"
      "start #{consuming}"
    end
  end

  def indifferent; "I don’t hate myself when I #{transition}"; end
  def hate; "I hate myself when I #{transition}"; end
end
