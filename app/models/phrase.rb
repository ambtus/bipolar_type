class Phrase < Array

  def inspect; join(" "); end

  def words; to_a; end

  def method_missing(meth, *arguments, &block)
    if last.respond_to?(meth)
     self[-1] = last.send(meth)
     return self
    else
     super
    end
  end

end
