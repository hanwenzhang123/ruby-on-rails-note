---
title: Ruby-on-Rails Concepts
---

## Table of Contents
- [Ruby Blocks, Procs & Lambdas](#Ruby-Blocks-Procs-&-Lambdas)
- [Ruby Engines](#Ruby-Engines)
- [Skinny-Fat Controller and Model](#Skinny-Fat-Controller-and-Model)
- [Decorator](#Decorator)
- [concerns](#concerns)
- [include and extend](#include-and-extend)
- [Modify Array](#modify-array)
- [Shallow Copy Deep Copy](#shallow-copy-deep-copy)


## Ruby Blocks Procs & Lambdas
- all used for defining and working with blocks of code, often passed as arguments to methods.
- all used for creating flexible and reusable code.

#### Blocks
- a piece of code enclosed within {} or do...end and is not an object in itself.
```
[1, 2, 3].each do |number|
  puts number
end
```

#### Procs
- an object that encapsulates a block of code and can be assigned to a variable, passed as a parameter, or returned from a method.
```
my_proc = Proc.new { |x| x * 2 }
puts my_proc.call(3) # Output: 6
```

#### Lambdas
- similar to a proc in that it's a block of code that can be assigned to a variable, passed around, and called a method.
- lambdas have a stricter argument count and behavior when it comes to returning from the enclosing method.
```
my_lambda = lambda { |x| x * 2 }
puts my_lambda.call(3) # Output: 6
```

#### Procs vs Lambdas
- Lambdas require a strict number of arguments, while procs are more lenient. If you pass the wrong number of arguments to a lambda, it will raise an error, while a proc may not.
- In Lambda, `return` exits the lambda itself, while in a proc, it exits the enclosing method.
- Lambdas capture the current scope, while procs capture the local scope of their creation.

In this example, the return from the proc exits the method itself, while the return from the lambda only exits the lambda and the method continues executing.
```
def my_method
  my_proc = Proc.new { return "Proc" }
  my_lambda = lambda { return "Lambda" }
  my_proc.call
  my_lambda.call
  "End of method"
end

puts my_method # Output: "Proc"
```

## Ruby Engines
https://guides.rubyonrails.org/engines.html

To create a Rails engine, you can use the Rails plugin's new command, and it will generate the necessary directory structure for an engine. You can then build your engine's functionality in a way that is similar to building a regular Rails application.

```ruby
rails plugin new my_engine
```

## Skinny-Fat Controller and Model
https://dev.to/kputra/rails-skinny-controller-skinny-model-5f2k#phase-3

#### Skinny Controller
- Keep your controller classes minimal and focused on handling HTTP requests, routing, and delegating the actual business logic to other parts of your application, such as models or services. 


## Decorator
- separate presentation logic from your models and views
- API that you decorate to make it look better (not to make it easier to use)

## concerns
The term "concerns" refers to a mechanism for modularizing and organizing code within your application. Concerns allow you to group related code that can be shared across multiple models or controllers, promoting code reusability and maintainability. Concerns are often used to encapsulate common functionality, such as methods, validations, or callbacks, and then include or extend these concerns in your models or controllers.

Concerns are typically defined in separate modules, and Rails provides a built-in way to include or extend these modules in your classes.

```ruby
# app/models/concerns/file_uploadable.rb
module FileUploadable
  extend ActiveSupport::Concern

  included do
    # Define methods, validations, or callbacks that are related to file uploads.
  end
end

# app/models/user.rb
class User < ApplicationRecord
  include FileUploadable
end

# app/controllers/posts_controller.rb
class PostsController < ApplicationController
  extend FileUploadable
end
```

## include and extend
- Both are used to share common functionality among different classes for code organization, modularization, and creating reusable code in Ruby on Rails.

#### `include` - add instance methods to a class
- used to mix instance methods from a module into a class
- include a module in a class, the methods defined in the module become available as instance methods of the class.

```ruby
module MyModule
  def some_instance_method
    # ...
  end
end

class MyClass
  include MyModule
end

obj = MyClass.new
obj.some_instance_method # This will work

```

#### `extend` - add class methods
- add module methods as class methods to a class - the methods from the module become accessible as class methods, rather than instance methods.
- useful when you want to add utility methods that are not tied to specific instances of a class but are related to the class itself.

```ruby
module MyModule
  def self.some_class_method
    # ...
  end
end

class MyClass
  extend MyModule
end

MyClass.some_class_method # This will work
```

## Modify Array
```ruby
def modify_item(item)
  return item # modify here
end
```

1. `each_with_index` Method for In-Place Modification:
```ruby
original_array.each_with_index do |item, index|
  modified_item = modify_item(item)
  original_array[index] = modified_item
end
```

2. `map!` Method for Transformation:
```ruby
original_array.map! do |item|
  modify_item(item)
end
```

3. `map` Method for a New Array:
```ruby
modified_array = original_array.map do |item|
  modify_item(item)
end
```

#### `each` Method
modifying the item here won't affect the original array
```ruby
original_array.each do |item|
  # This block is executed for each element in the array
  # However, modifying item here won't affect the original array
end
```

#### freeze/unfreeze Array
can not modify the frozen array, this way to unfreeze the array
```ruby
frozen_array = [1, 2, 3].freeze
duplicated_unfreeze_array = frozen_array.dup
duplicated_unfreeze_array << 4
puts frozen_array  # Output: [1, 2, 3]
puts duplicated_unfreeze_array  # Output: [1, 2, 3, 4]
```


## Shallow Copy Deep Copy
#### Shallow Copy
1. dup
```ruby
shallow_copy = original_array.dup
```
2. clone
```ruby
shallow_copy = original_array.clone
```
3. Array.new
```ruby
shallow_copy = Array.new(original_array)
```
4. to_a
```ruby
shallow_copy = original_array.to_a
```
5. splat operator (*)
```ruby
shallow_copy = *original_array
```

#### Deep Copy
1. json
```ruby
origin_array = [1, 2, 3]
copy_array = JSON.parse(origin_array.to_json)
copy_array << 4
puts origin_array  # Output: [1, 2, 3]
puts copy_array  # Output: [1, 2, 3, 4]
```
2. Marshal.load(Marshal.dump(@object))
```ruby
def deep_copy(obj)
  Marshal.load(Marshal.dump(obj))
end
```
3. deep_copy()
```ruby
def deep_copy(obj)
  if obj.is_a?(Array)
    obj.map { |element| deep_copy(element) }
  elsif obj.is_a?(Hash)
    obj.each_with_object({}) { |(key, value), hash| hash[deep_copy(key)] = deep_copy(value) }
  else
    obj.dup
  end
end
```
```ruby
def deep_copy(obj)
  obj.map { |element| element.is_a?(Array) ? deep_copy(element) : element.dup }
end
```
