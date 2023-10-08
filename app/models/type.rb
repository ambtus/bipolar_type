class Type

  def self.my_path; Time.now.dst? ? 'UAE•GMS•UFS•GPE•A•1' : 'UAE•GMS•UFS•GPE•B•1' ; end
  def self.my_type; self.new my_path; end

  def initialize(string)
    parts = string.split('•')
    @natures = parts[0,4].collect{|x| Behavior.send(x)}.sort
    @natures.check_constraints Behavior, 4, 4
    @realms = @natures.map(&:realm)
    @realms.check_constraints Realm, 4, 4
    @phases = @natures.map(&:phase)
    @phases.check_constraints Phase, 4, 4
    @hours = Hours.send(parts.fifth) rescue Hours.average
    @bipolar = parts.sixth.to_i rescue 1
    set_symbol
  end
  attr_reader :symbol, :natures, :realms, :phases, :hours, :bipolar

  def inspect; @symbol; end
  def name; inspect; end

  def set_symbol; @symbol = [*natures.map(&:symbol), @hours.symbol, @bipolar].join('•'); end

  def set_hours(avian); @hours = avian; set_symbol; end
  def hours_range(phase); hours.range(phase); end

  def set_bipolar(i); @bipolar = i; set_symbol; end

  def by_phase; Phase.all.collect{|p| natures.find{|b| b.phase == p}}; end

  def donts(phase)
    case bipolar
    when 1
      case phase
      when Phase.first
        [natures.first]
      when Phase.second
        []
      when Phase.third
        [natures.third]
      when Phase.fourth
        []
      end
    when 2
      case phase
      when Phase.first
        []
      when Phase.second
        [natures.second]
      when Phase.third
        []
      when Phase.fourth
        [natures.fourth]
      end
    end
  end

  def lesses(phase)
    case bipolar
    when 1
      case phase
      when Phase.first
        [natures.third.opposite]
      when Phase.second
        []
      when Phase.third
        [natures.first.opposite]
      when Phase.last
        [natures.fourth, natures.third.balancer]
      end
    when 2
      case phase
      when Phase.first
        []
      when Phase.second
        [natures.fourth.opposite]
      when Phase.third
        [natures.third, natures.fourth.balancer]
      when Phase.fourth
        [natures.second.opposite]
      end
    end
  end

  def dos(phase)
    case bipolar
    when 1
      case phase
      when Phase.first
        [natures.fourth.displacer]
      when Phase.second
        [natures.third.displacer, natures.fourth.opposite]
      when Phase.third
        [natures.second.displacer]
      when Phase.fourth
        [natures.second.opposite]
      end
    when 2
      case phase
      when Phase.first
        [natures.first, natures.fourth.displacer]
      when Phase.second
        [natures.third.displacer]
      when Phase.third
        [natures.first.opposite]
      when Phase.fourth
        [natures.first.displacer]
      end
    end
  end

  def mores(phase)
    case bipolar
    when 1
      case phase
      when Phase.first
        [natures.second.balancer]
      when Phase.second
        [natures.fourth.opposite, natures.first.balancer]
      when Phase.third
        [natures.fourth.balancer]
      when Phase.last
        [natures.first.displacer]
      end
    when 2
      case phase
      when Phase.first
        [natures.third.opposite, natures.second.balancer]
      when Phase.second
        [natures.first.balancer]
      when Phase.third
        [natures.second.displacer]
      when Phase.fourth
        [natures.third.balancer]
      end
    end
  end


end

