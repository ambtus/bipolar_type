class Stopping < Sign

  ALL = LETTERS.collect{|letter| self.new letter}

  def why(energy)
    case string
    when "e" #positive external signal
      "I feel #{energy.full}"
    when "i" #negative internal signal
      "the #{energy.reality_is_too_bad}"
    end.to_phrase
  end

end
