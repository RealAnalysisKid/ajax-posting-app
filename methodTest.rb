class Foo
  def self.bar
    puts "class method"
  end

  def baz
    puts "instance method"
  end
end

#Foo.bar
#Foo.baz

Foo.new.baz
Foo.new.bar
