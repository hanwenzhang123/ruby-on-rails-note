# Printing
puts "Hello"    # with a new line
print "World"   # print on the same line
puts "!"


# Variables & Data Type - ruby is dynamically typed
=begin
 Names are case-sensitive and may begin with:
     letters, _
 After, may include
     letters, numbers, _
 Convention says
     Start with a lowercase word, then additional words are lowercase separated
     by an underscore
     ex. my_first_variable
=end
name = "Mike"     # Strings
age = 30          # Integer
gpa = 3.5         # Decimal (Double)
is_tall = true    # Boolean -> True/False

name = "John"

puts "Your name is #{name}"
puts "Your name is " + name   #concat


# Casting and Converting
puts  3.14.to_i  #3 - toInteger
puts  3.to_f  #3.0 - toFloat
puts 3.0.to_s  #"3.0" - toString

puts 100 + "50".to_i  #150
puts  100 + "50.99".to_f  #150.99


# Strings
greeting = "Hello"
#indexes:   01234

puts greeting.length  # 5
puts greeting[0]  # H
puts greeting.include? "llo"  # true
puts greeting.include? "z"  # false
puts greeting[1,3]  # ell


# Numbers
puts  2 * 3         # Basic Arithmetic: +, -, /, *
puts  2**3          # Exponent
puts  10 % 3        # Modulus Op. : returns remainder of 10/3
puts  1 + 2 * 3     # order of operations
puts 10 / 3.0       # int's and doubles


num = 10
num += 100          # +=, -=, /=, *=
puts num    # 110

num = -36.8
puts  num.abs()   # absolute value 36.8
puts  num.round() # round -37

# Math class has useful math methods
puts Math.sqrt(144)   # 12.0
puts Math.log(0)  # Infinity


# User Input
puts "Enter your name: "
name = gets        # gets is reserved world which store the result, print in a new line
name = gets.chomp   # with chomp, the variable will be printed on the same line
puts "Hello #{name}, how are you"

puts "Enter first num: "
num1 = gets.chomp
puts "enter second num: "
num2 = gets.chomp
puts num1.to_f + num2.to_f



# Arrays
lucky_numbers = [4, 8, "fifteen", 16, 23, 42.0]
#       indexes  0  1       2      3   4   5

lucky_numbers[0] = 90
puts lucky_numbers[0]
puts lucky_numbers[1]
puts lucky_numbers[-1]  # 42.0

puts "\n\n"
puts lucky_numbers[2,3]  # from 2 and get 3 elements after 2
puts "\n\n"
puts lucky_numbers[2..4] # grab element 2 through 4
puts "\n\n"

puts lucky_numbers.length # 6


# 2 Dimensional Arrays
number_grid = [[],[]]
# numberGrid = [ [1, 2], [3, 4] ]
number_grid[0][0] = 99

puts number_grid[0][0]  # 99
puts number_grid[0][1]  # 2


# Array Methods
friends = []
friends.push("Oscar")
friends.push("Angela")
friends.push("Kevin")

# friends.pop   # remove last element from the array
puts  friends
puts "\n"

puts friends.reverse
puts "\n"

puts friends.sort
puts "\n"

puts  friends.include? "Oscar"  # true


# Methods
def add_numbers(num1, num2=99)    # default parameter value
     return num1 + num2
end

sum = add_numbers(4, 3)
puts sum


# If Statements - Conditional
is_student = false
is_smart = false

if is_student and is_smart
	puts "You are a student"
elsif is_student and !is_smart # negation symbol
	puts "You are not a smart student"
else
	puts "You are not a student and not smart"
end   # ending with the end keyword

# >, <, >=, <=, !=, ==, String.equals()   # == check for equality
if 1 > 3    # false
	puts "number comparison was true"
end

if "a" > "b"    # true, a is before b in alphabet
     puts "string comparison was true"
end


# Switch Statements
my_grade = "A"
case my_grade
     when "A"
		puts "You Pass"
     when "F"
     	puts "You fail"
     else
     	puts "Invalid grade"    # default case
end


# Dictionaries - key needs to be unique
test_grades = {
    "Andy" => "B+",
    :Stanley => "C",    # we can use a : to represent the key
    "Ryan" => "A",
    3 => 95.2   # we can use number to represent the key
}

test_grades["Andy"] = "B-"    # modify the value
puts test_grades["Andy"]
puts test_grades[:Stanley]
puts test_grades[3]


# While Loops
index = 1
while index <= 5
	puts index
	index += 1
end


# For Loops
for index in 0..5   # for every number range 0 to 5
    puts index    # 0 1 2 3 4 5
end

5.times do |index|  # 5 times to print out
    puts index  # 0 1 2 3 4
end

lucky_nums = [4, 8, 15, 16, 23, 42]
for lucky_num in lucky_nums
    puts lucky_num    # print out each number in lucky_nums
end

lucky_nums.each do |lucky_num|
     puts lucky_num    # print out each number in lucky_nums
end


# Exception Catching - when you do something that may break your program
begin 
     # puts bad_variable
     num = 10/0
rescue       # if the code breaks, it will go to the rescue
     puts "Error"
end


begin
     # puts bad_variable
     num = 10/0
rescue ZeroDivisionError    # catch a specific error, you can put multiple rescue
     puts "Error"
rescue              # default error, all kind of other error
     puts "All other errors"
end

raise "Made Up Exception"  # you can throw your own custom exception


# Classes and Objects - OOP, everything in Ruby is an object
class Book
     attr_accessor :title, :author  # defind the attribute

     def readBook()   # defind the method inside the class
          puts "Reading #{self.title} by #{self.author}"  # self refers to the specific object
     end
end

book1 = Book.new()
book1.title = "Harry Potter"
book1.author = "JK Rowling"

book1.readBook()
puts book1.title


# Constructors
class Book
     attr_accessor :title, :author
     def initialize(title, author)  # with keyword initalize you create the constructor, you can define more than one
          @title = title
          @author = author
     end

     def readBook()
          puts "Reading #{self.title} by #{@author}"
     end
end

book1 = Book.new("Harry Potter", "JK Rowling")  # when call .new() which is calling the initialize method
# book1.title = "Half-Blood Prince"

puts book1.title


# Getters and Setters - design pattern that controls access from the outside code to your class
class Book
     attr_accessor :title, :author
     def initialize(title, author)
          self.title = title
          @author = author
     end

     def title=(title)    # create a function, setter
          puts "Set"
          @title = title
     end
     def title     # create a function, getter
          puts "Get" 
          return @title
     end
end

book1 = Book.new("Harry Potter", "JK Rowling")

puts book1.title


# Inheritance
class Chef
     attr_accessor :name, :age
     def initialize(name, age)
          @name = name
          @age = age
     end

     def make_chicken()
          puts "The chef makes chicken"
     end

     def make_salad()
          puts "The chef makes salad"
     end

     def make_special_dish()
          puts "The chef makes a special dish"
     end
end

class ItalianChef < Chef       # inheritance using the less than sign <
     attr_accessor :country_of_origin
     def initialize(name, age, country_of_origin)
          @country_of_origin = country_of_origin
          super(name, age)  # call the constructor from the super class
     end

     def make_pasta()
          puts "The chef makes pasta"
     end

     def make_special_dish()     # overwriting the special dish method
          puts "The chef makes chicken parm"
     end
end

my_chef = Chef.new()
my_chef.make_chicken()

my_italian_chef = ItalianChef.new()
my_italian_chef.make_chicken()
