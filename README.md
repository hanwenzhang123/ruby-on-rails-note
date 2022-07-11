# Ruby on Rails Note

## MVC Model
- Model - resources in the app => database 
- View - frontend => UI
- Controller - how user request being handled => logic

#### General Flow of Rails Application
<details>
  <summary>How Rails App Works</summary>
  
  - Request made at browser
  - Request received at router of rails application
  - Request routed to appropriate action in a controller
  - Controller#action either renders a view template or communicates with model
  - Model communicates with database
  - Model sends back information to controller
  - Controller renders view
</details>

#### Naming Convention
<details>
  <summary>How to Name Properly</summary>
  
  - Model name: article
  - Class name: Article -> Capitalized A and singular, CamelCase
  - File name: article.rb -> singular and all lowercase, snake_case
  - Table name: articles -> plural of model name and all lowercase
</details>

#### File Structures
<details>
  <summary>How Repositiries Organized</summary>
  
```ruby
# repositories
  app - hold the mvc, assets (images, js, stylesheets), helpers, mailers => most of time where you write your code
    - models
    - views
    - controllers
    - helpers: view helpers, helping us to write code in views
    - assets: javascript, style sheets, some fundamentals images
    - mailers: like have your application send emails
    - jobs: write tasks your app do, like have your app run a certain job every night at midnight etc
    - channels: action cabel
  bin - ruby script like bundle commands rail commands etc
  config - configuration code that your app needs (database.yml routes.rb - add new routes)
  db - for database, sqlite for default, migration, do not update schema.rv directly
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
</details>

## Rails Commands
- `rails server`, `rails s` - start rails server
- `rails console`, `rails c` - rails console
- `reload!` - reload the console
- `rails new my-app` - generate a new project
- `rails generate controller pages` - Create a pages controller 
- `rails generate migration create_articles` - To generate a migration to create a table called Article
- `rails db:migrate` - To run the migration file
- `rails db:rollback` - to rollback or undo the changes made by the last migration file that was run
- `rails routes --expanded` - check routes, to see routes presented in a viewer-friendly way
- `rails generate scaffold Article title:string description:text` - to create an article model (with two attributes), articles controller, views for articles and migration file to create articles table:

#### A collapsible section with markdown
<details>
  <summary>Type of the Attributes </summary>
  
```ruby
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
```
</details>
