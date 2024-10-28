class Tendency < Concept

  SYMBOL = %w{IP IJ EP EJ}

  ALL = SYMBOL.collect {|symbol| self.new symbol}

  def +(concept)
    Subtype.all.find{|p| p.tendency == self && p.thing == thing}
  end

  def role_key; %w{C R E A}[index]; end
  def problem_key; %w{R C A E}[index]; end
  def solution_key; %w{A E R C}[index]; end
  def herring_key; %w{E A C R}[index]; end

  %w{problem solution role herring}.each do |string|
    define_method(string + '_time') {Help.find_by(self.send(string + '_key')).time}
  end

  def opposite; ALL.values_at(1,0,3,2)[index]; end
  def flip; ALL.values_at(2,3,0,1)[index]; end

  def more?; [0,3].include?(index); end

  def help; Help.all.find{|h| h.tendency_key == symbol}; end

  def method_missing(meth, *args, **kwargs, &block)
    if help.respond_to?(meth)
      help.send(meth)
    else
      super(meth)
    end
  end

end
