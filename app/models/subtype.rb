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
  def self.each(&block);ALL.each(&block); end

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

  def symbol; @pair.map(&:symbol).map(&:chars).flatten.values_at(1,0,2).join; end
  def inspect; symbol; end

  SYMBOLS = ALL.map(&:symbol)
  SYMBOLS.each do |path|
    define_singleton_method(path) {ALL[SYMBOLS.index(path)]}
  end


  def description; "#{verb} #{adjective} #{noun}"; end
  def name; "#{description.titleize}"; end

  ALL.each{|s| define_singleton_method(s.path) {s}}
  def self.paths; ALL.map(&:path); end

  def siblings; attitude.subtypes + realm.subtypes - [self]; end

  def types; Type.all.select{|t| t.subtypes.include?(self)}; end

end
