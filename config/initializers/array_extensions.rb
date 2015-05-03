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
end
