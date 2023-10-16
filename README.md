---
title: Ruby-on-Rails
---

## MVC Model => What is MVC
  
```
  - **Model (ActiveRecord):** the data and the database, the structure of data, resources in the app, the format and the constraints with which it is stored
  - **View (ActionView):** the user interface, frontend, what is presented to the user, and what the user sees
  - **Controller (ActionController):** request-response handler, how user request being handled, controls the requests of the user and then generates appropriate response to the viewer
  - **ActiveRecord:** A model layer, a middleman ORM to communicate between Rails application code and database table
```


## General Flow of Rails Application => How Rails App Works
  
```
  - Request made at browser
  - Request received at router of rails application
  - Request routed to appropriate action in a controller
  - Controller#action either renders a view template or communicates with model
  - Model communicates with database
  - Model sends back information to controller
  - Controller renders view
```

## Rails Architecture => Diagram
  
```
broswer - web server - public - routing
               \                 |
                \            controller
                 \             |   |
                    -------- view model - database
```

## Naming Convention => How to Name Properly
  
```
  - Model name: article
  - Class name: Article -> Capitalized A and singular, CamelCase
  - File name: article.rb -> singular and all lowercase, snake_case
  - Table name: articles -> plural of model name and all lowercase
```

## File Structures => How Repositiries Organized
  
```ruby
# repositories
  app - hold the mvc, assets (images, js, stylesheets), helpers, mailers => most of time where you write your code
    - models
    - views
    - controllers
    - helpers: view helpers, helper methods that helping us to write code in views
    - assets: javascript, style sheets, some fundamentals images
    - mailers: like have your application send emails
    - jobs: write tasks your app do, like have your app run a certain job every night at midnight etc
    - channels: action cabel
  bin - ruby script like bundle commands rail commands etc
  config - configuration code that your app needs (database.yml routes.rb - add new routes)
  db - for database, sqlite for default, migration, do not update schema.rv directly
  engine - miniature applications that provide functionality to their host applications
  lib - reusable code library, two directory assets and tasks
  log - application log files, good for debugging
  public - public files like 404 or html
  test - write test for application
  tmp - hold temporary files like hash caching etc
  vendor - hold third party files, code, etc

# files
  Gemfile - which dependencies are needed in the application, install and update by gem
  Gemfile.lock - which dependencies are needed in the application, install and update by gem
  Rakefile - locate and load path that can be run from the command line
  README.rdoc - introduction of the application
```

## Business Logic Model vs Controller 
- Keep business logic directly related to data, data validation, and data manipulation in the model.
- Keep business logic related to HTTP request handling and user interactions in the controller.
- Use service objects or additional Ruby classes for complex business logic that doesn't fit neatly into either the model or controller. This promotes a clean separation of concerns and modularity.

