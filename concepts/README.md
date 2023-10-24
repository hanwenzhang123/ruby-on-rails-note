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

## Ruby Blocks Procs & Lambdas
- all used for defining and working with blocks of code, often passed as arguments to methods.
- all used for creating flexible and reusable code.

#### Blocks

#### Procs

#### Lambdas

## Ruby Engines
https://guides.rubyonrails.org/engines.html

To create a Rails engine, you can use the rails plugin new command, and it will generate the necessary directory structure for an engine. You can then build your engine's functionality in a way that is similar to building a regular Rails application.

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
