---
title: Ruby-on-Rails
---

## MVC Model => What is MVC
  
```
  - **Model (ActiveRecord):** the data and the database, the structure of data, resources in the app, the format, and the constraints with which it is stored
  - **View (ActionView):** the user interface, frontend, what is presented to the user, and what the user sees
  - **Controller (ActionController):** request-response handler, how user request being handled, controls the requests of the user and then generates an appropriate response to the viewer
  - **ActiveRecord:** A model layer, a middleman ORM to communicate between Rails application code and database table
```


## General Flow of Rails Application => How Rails App Works
  
```
  - Request made at the browser
  - Request received at the router of rails application
  - Request routed to appropriate action in a controller
  - Controller#action either renders a view template or communicates with the model
  - Model communicates with the database
  - Model sends back information to the controller
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
  - Table name: articles -> plural of the model name and all lowercase
```

## File Structures => How Repositories Organized
  
```ruby
# repositories
  app - hold the mvc, assets (images, js, stylesheets), helpers, mailers => most of the time where you write your code
    - models: represent the data structures and interact with the database
    - controllers: handle incoming HTTP requests, manage the business logic, and render views
    - views: templates for rendering HTML
    - helpers: provide utility methods for views, helper methods that help us to write code in views
    - assets: javascript, style sheets, some fundamental images
    - mailers: have your application send emails
    - jobs: write tasks your app does, like have your app run a certain job every night at midnight, etc
    - channels: action cable
    - services: store complex business logic or interactions with external systems to keep mvc clean, focused on a single responsibility, like authentication
    - serializer: ActiveModel Serializer controls the format and structure of the data you send as a response, how data is presented when you return it from your API
    - concerns: ActiveSupport Concerns organizes shared pieces of functionality within models, controllers, and other parts of your application, eg: app/models/concerns 
  bin - scripts for application setup like bundle commands, rail commands, etc
  config - configuration code in your application
    - routes.rb - map incoming HTTP requests to controller actions, add new routes
    - application.rb - global application settings
    - database.yml - configure database connections
    - initializers - run when the application starts to set up 
  db - for database related
    - migration - database migration files that define changes to your database schema
    - schema.rb - the current database schema, do not update schema.rb directly
    - seeds.rb - for populating the database with initial data.
  engine - miniature applications that provide functionality to their host applications
  lib - reusable code library, two directory assets, and tasks, often used for custom libraries or classes.
  log - application log files, good for debugging
  public - public static files like 404 or HTML, images
  test - tests for the application like unit and integration tests
  tmp - hold temporary files like hash caching, PID, etc
  vendor - hold third-party files, code, etc
    - assets: For third-party JavaScript, CSS, and other assets.
    - plugins: For third-party Ruby gems or plugins.
# files
  Gemfile - which dependencies are needed in the application, install and update by gem
  Gemfile.lock - which dependencies are needed in the application, installed and updated by gem
  Rakefile - locate and load path that can be run from the command line
  README.rdoc - introduction of the application
```

## Business Logic Model vs Controller 
- Keep business logic directly related to data, data validation, and data manipulation in the model.
- Keep business logic related to HTTP request handling and user interactions in the controller.
- Use service objects or additional Ruby classes for complex business logic that doesn't fit neatly into either the model or controller. This promotes a clean separation of concerns and modularity.

