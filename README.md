---
title: Ruby-on-Rails Notes
---

## Table of Contents
- [MVC Model](#MVC-Model)
- [Rails Commands](#Rails-Commands)
- [Code Samples](#Code-Samples)


## MVC Model
- **Model (ActiveRecord):** the data and the database, the structure of data, resources in the app, the format and the constraints with which it is stored
- **View (ActionView):** the user interface, frontend, what is presented to the user, and what the user sees
- **Controller (ActionController):** request-response handler, how user request being handled, controls the requests of the user and then generates appropriate response to the viewer
- **ActiveRecord:** A model layer, a middleman ORM to communicate between Rails application code and database table


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


#### Rails Architecture
<details>
  <summary>Rails Architecture Diagram</summary>
  
```
broswer - web server - public - routing
               \                 |
                \            controller
                 \             |   |
                    -------- view model - database
```
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
- `rails new my-app` - generate a new project
- `rails server`, `rails s` - start rails server
- `rails console`, `rails c` - rails console
- `reload!` - reload the console
- `rails routes --expanded` - check routes presented in a viewer-friendly way
- `rails generate migration name_of_migration_file` - generate migration
- `rails generate migration create_articles` - generate a migration to create an Article table
- `rails db:migrate` - run the migration file
- `rails db:rollback` - rollback or undo the changes made by the last migration
- `rails generate controller pages` - create a pages controller 
- `rails g model Post title:string body:text` - create a model file for us
- `rails generate scaffold Article title:string description:text` - to create an article model (with two attributes), articles controller, views for articles and migration file to create articles table

#### A collapsible section with markdown
<details>
  <summary>Type of the Data Attributes</summary>
  
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


## Code Samples
### Database
Open rails console
- `ModalName.all`
- `ModalName.first`
- `ModalName.last`
- `ModalName.new`
- `ModalName.save`
- `ModalName.destroy`
- `ModalName.find(id)`

#### app/models/article.rb
<details>
  <summary>Show Code</summary>
  
```ruby
class Article < ApplicationRecord
  validates :title, presence: true, length: { minimum: 6, maximum: 100 }
  validates :description, presence: true, length: { minimum: 10, maximum: 300 }
end
```
</details>


#### db/migrate
<details>
  <summary>Show Code</summary>
  
```ruby
class AddTimestampsToArticles < ActiveRecord::Migration[6.0]
  def change
    add_column :articles, :created_at, :datetime    #table name, attribute name, data type
    add_column :articles, :updated_at, :datetime
  end
end
```
</details>

#### db/schema.rb
<details>
  <summary>Show Code</summary>
  
```ruby
ActiveRecord::Schema.define(version: 2020_03_12_131609) do
  create_table "articles", force: :cascade do |t|
    t.string "title"    #add attributes for the table in the migration file
    t.text "description"
    t.datetime "created_at"
    t.datetime "updated_at"
  end
end
```
</details>


### Controller
#### app/controllers/articles_controller.rb
<details>
  <summary>Show Code</summary>
  
```ruby
class ArticlesController < ApplicationController
  def show
    @article = Article.find(params[:id])  #params that sends in the id in hash format
  end
  def index
    @articles = Article.all  #save values to an instance variable
  end
  def new
    @article = Article.new
  end
  def create
    @article = Article.new(params.require(:article).permit(:title, :description))
    if @article.save
      flash[:notice] = "Article was created successfully."
      redirect_to @article 
    else
      render 'new'
    end
  end
end
```
</details>


### Config
#### config/routes.rb
<details>
  <summary>Show Code</summary>
  
```ruby
Rails.application.routes.draw do
  root 'pages#home'
  get 'about', to: 'pages#about'
  resources :articles, only: [:show, :index, :new, :create]    #get all the routes available using keyword resources
end
```
</details>
 
