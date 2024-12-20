class Tendency < Concept

  SYMBOL = %w{IP IJ EP EJ}

  ALL = SYMBOL.collect {|symbol| self.new symbol}

  def role_key; %w{C R E A}[index]; end
  def problem_key; %w{R C A E}[index]; end
  def solution_key; %w{A E R C}[index]; end
  def herring_key; %w{E A C R}[index]; end

  %w{problem solution role herring}.each do |string|
    define_method(string + '_time') {Help.find_by(self.send(string + '_key')).time}
  end

  def more?; [0,3].include?(index); end
  def inverted?; symbol.second == 'J'; end
  def morning?; symbol.first == 'E'; end

  def sick; morning? ? 'manic' : 'depressed'; end
  def drugs; morning? ? 'stimulants' : 'sedatives'; end

  def help; Help.all.find{|h| h.tendency_key == symbol}; end

  def subtypes; Subtype.all.select{|s| s.tendency == self}; end

  def method_missing(meth, *args, **kwargs, &block)
    if help.respond_to?(meth)
      help.send(meth)
    else
      super(meth)
    end
  end

end
