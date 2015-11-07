# Restart required even in development mode when you modify this file.

%w{to_phrase to_word to_word_or_phrase multiply add sixth seventh eighth dupes without}.each do |meth|
 raise "#{meth} is already defined in Array" if Array.method_defined?(meth)
end

class Array

  def to_phrase; Phrase.new(self); end
  def to_word(space=" "); Word.new(self.join(space)); end
  def to_word_or_phrase
    case size
    when 0
      raise "#{self} has no words"
    when 1
      to_word
    else
      to_phrase
    end
  end

  def multiply(target, method=:+)
    b = Array.new
    self.each do |row|
      a = Array.new
      target.each do |column|
        a << row.send(method, column)
      end
      b << a
    end
    b
  end

  def add(target, method=:+)
    a = Array.new
    target = Array.new(self.size, target) unless target.is_a?(Array)
    self.each_with_index do |row,index|
      a << row.send(method, target[index])
    end
    a
  end

  def sixth; self[5]; end
  def seventh; self[6]; end
  def eighth; self[7]; end

  def dupes
    dups = {}
    each_with_index do |val, idx|
      (dups[val] ||= []) << idx
    end
    dups.delete_if {|k,v| v.size == 1}.keys
  end

  def without(element)
    reject{|x| x == element}
  end
end
