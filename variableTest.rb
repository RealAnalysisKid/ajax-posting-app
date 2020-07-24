class Earth
  @@pollution = "low"

  #puts @@pollution
end

class HumanBorn < Earth
  @@pollution = "high"

  #puts @@pollution
end

######

class Polygon
  @@sides = 10
  def self.sides
    @@sides
  end
end

puts Polygon.sides

# 跟前面一段 Earth的示例代码一对比 就知道如何才能显示出output
# 尝试定义了self.pollution后 就能用 puts 调出显示了

# 好继续看看 “继承性”

class Triangle < Polygon
  @@sides = 3
end

puts Triangle.sides
puts Polygon.sides

class Rectangle < Polygon
  @@sides = 4
end

puts Rectangle.sides
puts Triangle.sides
puts Polygon.sides


class Polygon
  class << self; attr_accessor :sides end
  @sides = 8
end

class Triangle < Polygon
  @sides = 3
end

puts Triangle.sides
puts Polygon.sides


######

class Kid
  @age = 1
 def grow_up
   @age = @age +1
 end

 def show_age
   @age
 end
end

wayne = Kid.new
wayne.show_age

wayne.grow_up
wayne.show_age

jason = Kid.new
jason.show_age
