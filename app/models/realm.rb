class Realm < Concept

  SYMBOLS = %w{P M A F}

  ########
  ALL = SYMBOLS.collect {|symbol| self.new symbol}
  PATHS.each do |path|
    define_singleton_method(path) {ALL[PATHS.index(path)]}
  end
  ########

  def subtypes; Subtype.all.select{|s| s.realm == self}; end
  def +(attitude); subtypes.find{|s| s.attitude == attitude}; end

  def adjective; %w{physical mental affective financial}[index]; end

  def energy; %w{glucose data affect money}[index]; end
  def provide; %w{feed show tell hand}[index]; end
  def notice; %w{smell see hear touch}[index]; end
  def collect_w; %w{eat learn listen\ to fight\ for}[index]; end
  def collect; collect_w.split.first; end
  def process; %w{digest remember agree\ with win}[index]; end
  def resources; %w{foods facts opinions rewards}[index]; end
  def appear; %w{taste look sound feel}[index]; end
  def gather; [collect_w, resources].join(" "); end
  def harvest; "#{notice}, #{collect_w}, and #{process} #{resources} that #{appear} right"; end
  def energizers; %w{carbs specifics compliments battles}[index]; end
  def strengtheners; %w{proteins generalities criticisms wars}[index]; end
  def reserves; %w{fat knowledge values savings}[index]; end
  def empty; %w{hungry curious lonely overdrawn}[index]; end

  def practice; %w{walk think talk pay}[index]; end
  def accomplish; %w{go evaluate tell own}[index]; end
  def goal; %w{place idea person thing}[index]; end
  def goals; goal.pluralize; end
  def anything; %w{anywhere anything anyone anything}[index]; end
  def something; %w{somewhere something someone something}[index]; end
  def them_there; index > 0 ? "them" : "there"; end
  def easy; %w{flat simple allied cheap}[index]; end
  def hard; %w{high complex unrelated expensive}[index]; end
  def labor; [accomplish, goals].join(" "); end
  def strength; %w{muscle intelligence eloquence credit}[index]; end

end
