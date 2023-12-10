class Behavior < Concept

  def initialize(string)
    @symbol = string
    @phase = Phase.send(string.first)
    @realm = Realm.send(string.second)
  end
  attr_reader :symbol, :phase, :realm

  def path; Rails.application.routes.url_helpers.behavior_path(self.symbol); end

  ########
  ALL = Phase::SYMBOLS.collect do |phase|
          Realm::SYMBOLS.collect do |realm|
            self.new [phase, realm].join
          end
        end.flatten
  SYMBOLS = ALL.map(&:symbol)
  SYMBOLS.each {|s| define_singleton_method(s) {ALL[SYMBOLS.index(s)]}}
  ########

  def words; [realm.adverb, phase.word].to_phrase; end

  def <=>(other); self.phase <=> other.phase; end

  def siblings; Phase.all.add(realm); end
  def cousins; Realm.all.add(phase); end

  def previous; realm + phase.previous; end
  def next; realm + phase.next; end
  def balancer; realm + phase.switch_attitude; end
  def displacer; realm + phase.switch_focus; end
  def opposite; realm + phase.opposite;end
  # b.opposite.balancer == b.displacer

  def my_siblings; [self, displacer, balancer, opposite]; end

  def method_missing(meth, *arguments, &block)
    if phase.respond_to?(meth)
      phase.send(meth, *arguments, &block)
    elsif realm.respond_to?(meth)
      realm.send(meth, *arguments, &block)
    else
      super
    end
  end

  def description; phase.description.gsub('everything', "all #{realm.resources}").gsub('things', realm.resources); end

end
