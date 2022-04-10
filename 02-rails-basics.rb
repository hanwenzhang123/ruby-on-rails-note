MVC architecture - model(busines logic like data) view(UI) controller(control flow)
Convention over configuration - set default as the best way to do things
DRY (do not repeat yourself)

# run the server
ruby script/server - (In rails 2.x)
rails s - (In rails 3.x)

  
# generator
rails g
rails g controller home index

# generate a new project
# will run a bundle install (which installs gem)
rails new my-app

# start the server
rails server
    
  
# Gemfile - like package.json
  # bundle install is like npm install
A Gemfile is a file that is created to describe the gem dependencies required to run a Ruby program. 
  A Gemfile should always be placed in the root of the project directory.
     
Gemfile - dependencies required to execute associated Ruby code
bundle install - install dependencies

erb - embedded ruby

  
# repositories
  app - hold the mvc, assets (images, js, stylesheets), helpers, mailers
  bin - ruby script like bundle commands rail commands etc
  config - configuration code that your app needs (database.yml routes.rb - add new routes)
  db - for database, sqlite for default, migration, do not update schema.rv directly
  lib - reusable code library, two directory assets and tasks
  log - application log files, good for debugging
  public - public files like 404 or html
  test - write test for application
  tmp - hold temporary files like hash caching etc
  vendor - 
# files
  Gemfile - which dependencies are needed in the application, install and update by gem
  Gemfile.lock - which dependencies are needed in the application, install and update by gem
  Rakefile - locate and load path that can be run from the command line
  README.rdoc - introduction of the application
    
    
# The MVC Setup  
rails generate model Post title:string body:text
:string - used for small data types such as a title
:text - used for longer pieces of textual data such as a paragraph
:integer - used for storing whole numbers
:binary - used for storing data such as images, audio or video
:boolean - used for storing true and false values
:date - used for storing date
:datetime - used for storing the date and time in a single column
:timestamp - used for storing the data and time in a single column but converted to UTC and convert back
:decimal - used for storing decimals
:float - used for storing decimals, when you do not care about the precision of the number since it rounds
:primary_key - used for storing a unique key that can uniquely identify each row in a table

  
