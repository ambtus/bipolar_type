class Subtype

  def initialize(array)
    @energy = array.first
    @imbalance = array.second
  end
  attr_reader :energy, :imbalance

  ALL = Energy::ALL.collect do |energy|
          Imbalance::ALL.collect do | imbalance |
            self.new [energy,imbalance]
          end
        end.flatten

  def self.all; ALL; end

  def method_missing(meth, *arguments, &block)
    if energy.respond_to?(meth)
      energy.send(meth, *arguments, &block)
    elsif imbalance.respond_to?(meth)
      imbalance.send(meth, *arguments, &block)
    else
      super
    end
  end

  def <=>(other); imbalance.index <=> other.imbalance.index; end

  def path; [@energy.path, @imbalance.path].join; end
  def inspect; path; end
  def symbol; path.upcase; end

  ALL.each{|s| define_singleton_method(s.path) {s}}
  def self.paths; ALL.map(&:path); end

  def siblings; imbalance.subtypes + energy.subtypes - [self]; end

  def phrase; "#{@energy.adjective} #{@imbalance.noun}"; end
  def name; phrase.titleize; end

  def problem
    case noun
    when "addiction", "aversion"
      get
    when "paralysis", "compulsion"
      use
    end +
    case noun
    when "addiction", "compulsion"
      " less"
    when "paralysis", "aversion"
      " more"
    end
  end
  def solution
    case noun
    when "addiction", "aversion"
      use
    when "paralysis", "compulsion"
      get
    end +
    case noun
    when "addiction", "compulsion"
      " less"
    when "paralysis", "aversion"
      " more"
    end
  end

end
