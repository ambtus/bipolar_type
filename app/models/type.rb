class Type < Concept

  def self.my_path; 'PAFM' ; end
  def self.my_type; self.new my_path; end

  def path; Rails.application.routes.url_helpers.type_path(self.symbol); end

  def initialize(string)
    @realms = string.chars[0,4].collect{|x| Realm.send(x)}
    @realms.check_constraints Realm, 4, 4
    @hour = Hours.send(string[4,1]) rescue Hours.generic
    hour_symbol = @hour.generic? ? nil : @hour.symbol
    @symbol = [*@realms.map(&:symbol), hour_symbol].compact.join;
  end
  attr_reader :symbol, :realms, :hour

  ########
  ALL = Realm::SYMBOLS.permutation(4).collect{|x| new(x.join)}
  SYMBOLS = ALL.map(&:symbol)
  SYMBOLS.each {|s| define_singleton_method(s) {ALL[SYMBOLS.index(s)]}}
  ########

  def inspect; @symbol; end
  def name; inspect; end

  def behaviors; @realms.add(Phase.all); end

  def set_symbol
     hour_symbol = @hour.generic? ? nil : @hour.symbol
     @symbol = [*realms.map(&:symbol), hour_symbol].compact.join;
     self
  end

  def set_hour(avian); @hour = avian; set_symbol; end
  def hours_range(phase); hour.range(phase); end
  def start_time(phase); hour.start_time(phase); end

  def blues; behaviors.map(&:displacer); end
  def reds;   behaviors; end
  def greens;  behaviors.map(&:balancer) ; end
  def yellows; behaviors.map(&:opposite); end

  def colors; %w{blue green yellow red}; end
  def by_colors; [blues, greens, yellows, reds]; end
  def color_hash; [by_colors, (0...colors.size).to_a].transpose.to_h; end
  def color_index; h={}; color_hash.each {|k,v| k.each{|b| h[b] = v}}; h; end
  def color(behavior); colors[color_index[behavior]]; end

  def by_phase(phase, index); color_hash.invert[index].select{|b| b.phase == phase}; end
  def by_color(behavior); by_colors.collect{|ary| ary.select{|b| b.realm == behavior.realm}}.flatten; end

  def prefix(b); ['Do', 'And do', 'But don’t', 'And don’t' ][color_index[b]]; end
  def suffix(b); ['unless you can’t', 'unless you don’t want to', 'unless you want to', 'unless you have to' ][color_index[b]] end

  def long_advice(b); [prefix(b), b.name_eg, 'in the', b.time.downcase, suffix(b)].to_phrase.html_safe; end

end

