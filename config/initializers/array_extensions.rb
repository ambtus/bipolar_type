# Restart required even in development mode when you modify this file.

class Array
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
    self.each_with_index do |val, idx|
      (dups[val] ||= []) << idx
    end
    dups.delete_if {|k,v| v.size == 1}.keys
  end

  def without(element)
    self.reject{|x| x == element}
  end
end
