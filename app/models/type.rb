class Type

  def self.my_path; 'GPE•UAE•UFS•GMS' ; end
  def self.my_type; self.new my_path; end

  def initialize(string)
    parts = string.split('•')
    @behaviors = parts[0,4].collect{|x| Behavior.send(x)}
    @behaviors.check_constraints Behavior, 4, 4
    @realms = @behaviors.map(&:realm)
    @realms.check_constraints Realm, 4, 4
    @phases = @behaviors.map(&:phase)
    @phases.check_constraints Phase, 4, 4
    @hour = Hours.send(parts.fifth) rescue Hours.generic
    set_symbol
  end
  attr_reader :symbol, :behaviors, :realms, :phases, :hour

  def inspect; @symbol; end
  def name; inspect; end

  def set_symbol
     hour_symbol = @hour.generic? ? nil : @hour.symbol
     @symbol = [*behaviors.map(&:symbol), hour_symbol].compact.join('•');
     self
  end

  def set_hour(avian); @hour = avian; set_symbol; end
  def hours_range(phase); hour.range(phase); end
  def start_time(phase); hour.start_time(phase); end

  def blues; behaviors.map(&:previous); end
  def reds;   behaviors; end
  def greens;  behaviors.map(&:next) ; end
  def yellows; behaviors.map(&:opposite); end

  def colors; %w{blue green yellow red}; end
  def by_colors; [blues, greens, yellows, reds]; end
  def color_hash; [by_colors, (0...colors.size).to_a].transpose.to_h; end
  def color_index; h={}; color_hash.each {|k,v| k.each{|b| h[b] = v}}; h; end
  def color(behavior); colors[color_index[behavior]]; end

  def by_phase(phase, index); color_hash.invert[index].select{|b| b.phase == phase}; end
  def by_color(behavior); by_colors.collect{|ary| ary.select{|b| b.realm == behavior.realm}}; end

  def prefix(b); ['Do', 'And do', 'But don’t', 'And don’t' ][color_index[b]]; end
  def suffix(b); ['unless you can’t', 'unless you really don’t want to', 'unless you really want to', 'unless you have to' ][color_index[b]] end

  def long_advice(b); [prefix(b), b.name_eg, 'in the', b.time.downcase, suffix(b)].to_phrase.html_safe;
end
end

