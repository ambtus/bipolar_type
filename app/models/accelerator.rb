class Accelerator < Transition

  ########
  LETTERS = %w{j p}
  ALL = LETTERS.collect{|letter| self.new letter}
  def <=>(other); other.index <=> index; end
  ########

  def am(realm)
    case signal_location
    when "external"
      realm.strong
    when "internal"
      realm.energetic
    end
  end

end
