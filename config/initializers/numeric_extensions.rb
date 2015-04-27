# Restart required even in development mode when you modify this file.

class Fixnum
  def word
    %w{zero one two three four five six seven eight nine
       ten eleven twelve thirteen fourteen fifteen
       sixteen seventeen eighteen nineteen twenty}[self] || self.to_s
  end
end
