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

  def energy; %w{calories data love money}[index]; end
  def notice; %w{smell see hear touch}[index]; end
  def get; %w{eat look\ at listen\ to use}[index]; end
  def process; %w{digest believe accept wield }[index]; end
  def resources; %w{foods facts opinions tools}[index]; end
  def appear; %w{taste look sound feel}[index]; end
  def get_resources; [get, resources].join(" "); end
  def energizers; %w{carbs specifics praise cash}[index]; end
  def strengtheners; %w{proteins generalities criticism repayments}[index]; end
  def is_are; index == 2 ? "is" : "are"; end
  def reserves; %w{fat knowledge attachments savings}[index]; end

  def act; %w{walk think talk buy}[index]; end
  def achieve; %w{go consider tell charge}[index]; end
  def goals; %w{places ideas people things}[index]; end
  def anything; %w{anywhere anything anyone anything}[index]; end
  def something; %w{somewhere something someone something}[index]; end
  def them_there; index > 0 ? "them" : "there"; end
  def achieve_goals; [achieve, goals].join(" "); end
  def strength; %w{muscles theories vocabulary credit}[index]; end
  def it_them; index < 3 ? "them" : "it"; end
  def it_they; index < 3 ? "they" : "it"; end

end
