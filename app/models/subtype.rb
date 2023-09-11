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

  def description; "#{adjective} #{problem} (#{solution})" ; end
  def name; symbol; end

  def problem; "#{realm.adjective} #{position.surplus_or_deficit} "; end

  def reason
    case symbol
    when "ISJ"
      "cannot eat carbs when manic"
    when "INJ"
      "cannot look at pictures when manic"
    when "ITJ"
      "cannot earn wages when manic"
    when "IFJ"
      "cannot listen to music when manic"
    when "ISP"
      "cannot stop moving when manic"
    when "INP"
      "cannot stop intuiting when manic"
    when "ITP"
      "cannot stop spending cash when manic"
    when "IFP"
      "cannot stop crying when manic"
    when "ESJ"
      "cannot stop eating protein when depressed"
    when "ENJ"
      "cannot stop watching results when depressed"
    when "ETJ"
      "cannot stop investing when depressed"
    when "EFJ"
      "cannot stop listening to words when depressed"
    when "ESP"
      "cannot lift weights when depressed"
    when "ENP"
      "cannot use logic when depressed"
    when "ETP"
      "cannot use credit when depressed"
    when "EFP"
      "cannot use words when depressed"
    end
  end

  def solution
    case symbol
    when "ISJ"
      "don’t lift weights (walking is okay)"
    when "INJ"
      "don’t use logic (intuiting is okay)"
    when "ITJ"
      "don’t use credit (cash is okay)"
    when "IFJ"
      "don’t use words (emoting is okay)"
    when "ISP"
      "eat carbs (without protein)"
    when "INP"
      "look at pictures (without movement)"
    when "ITP"
      "earn wages (without investing)"
    when "IFP"
      "listen to music (without words)"
    when "ESJ"
      "lift weights (without running)"
    when "ENJ"
      "theorize (without intuiting)"
    when "ETJ"
      "charge it (without cash)"
    when "EFJ"
      "write (without emoting)"
    when "ESP"
      "don’t eat carbs (protein is okay)"
    when "ENP"
      "don’t look at pictures (results are okay)"
    when "ETP"
      "don’t earn wages (investing is okay)"
    when "EFP"
      "don’t listen to music (words are okay)"
    end
  end

end
