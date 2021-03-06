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
- `rails routes --expanded | grep edit` - show the routes with the keyword edit
- `rails generate migration name_of_migration_file` - generate migration
- `rails generate migration create_articles` - generate a migration to create an Article table
- `rails generate migration add_user_id_to_articles` - generate a migration to add the user_id column to articles table
- `rails db:migrate` - run the migration file
- `rails db:rollback` - rollback or undo the changes made by the last migration
- `rails generate controller pages` - create a pages controller 
- `rails g model Post title:string body:text` - create a model file for us
- `rails generate scaffold Article title:string description:text` - to create an article model (with two attributes), articles controller, views for articles and migration file to create articles table
- `rails generate migration add_password_digest_to_users` - create a migration file to add the password_digest column to the users table

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
### Model
<details>
  <summary>rails console</summary>
  
- `ModalName.all`
- `ModalName.first`
- `ModalName.last`
- `ModalName.new`
- `ModalName.save`
- `ModalName.destroy`
- `ModalName.find(id)`
- `ModalName.find_by(field_id: id)`
- `ModalName.update_all(field_id: id)`
</details>

<details>
  <summary>app/models/article.rb</summary>

```ruby
class Article < ApplicationRecord
  belongs_to :user  #association, singular since article can only belong to one user
  validates :title, presence: true, length: { minimum: 6, maximum: 100 }
  validates :description, presence: true, length: { minimum: 10, maximum: 300 }
end
```
</details>

<details>
  <summary>app/models/user.rb</summary>

```ruby
class User < ApplicationRecord
  before_save { self.email = email.downcase }
  has_many :articles  #association
  validates :username, presence: true, 
                      uniqueness: { case_sensitive: false }, 
                      length: { minimum: 3, maximum: 25 }
  VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i
  validates :email, presence: true, 
                      uniqueness: { case_sensitive: false }, 
                      length: { maximum: 105 },
                      format: { with: VALID_EMAIL_REGEX }
  has_secure_password #bcrypt gem => rails generate migration add_password_digest_to_users
end
```
</details>

<details>
  <summary>db/migrate</summary>
  
- You need to run rails db:migrate afterwards to add the fields after each modification
```ruby
#rails generate migration add_timestamps_to_articles
class AddTimestampsToArticles < ActiveRecord::Migration[6.0]
  def change
    add_column :articles, :created_at, :datetime    #table name, attribute name, data type
    add_column :articles, :updated_at, :datetime
  end
end
```
```ruby
#rails generate migration add_user_id_to_articles
class AddUserIdToArticles < ActiveRecord::Migration[6.0]
  def change
    add_column :articles, :user_id, :int
  end
end
```
```ruby
#rails generate migration add_password_digest_to_users 
#rails console => user = User.last, user.authenticate("password123")
class AddPasswordDigestToUsers < ActiveRecord::Migration[6.0]
  def change
    add_column :users, :password_digest, :string
  end
end
```
</details>

<details>
  <summary>db/schema.rb</summary>
  
```ruby
ActiveRecord::Schema.define(version: 2020_04_06_103010) do

  create_table "articles", force: :cascade do |t|
    t.string "title"  #add attributes for the table in the migration file
    t.text "description"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer "user_id"
  end

  create_table "users", force: :cascade do |t|
    t.string "username"
    t.string "email"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.string "password_digest"
  end

end
```
</details>
</details>
</details>


### Controller
<details>
  <summary>app/controllers/articles_controller.rb</summary>
  
```ruby
class ArticlesController < ApplicationController
  before_action :set_article, only: [:show, :edit, :update, :destroy]

  def show
    @article = Article.find(params[:id])  #params that sends in the id in hash format
  end
                                                
  def index
    @articles = Article.all  #save values to an instance variable
  end

  def new
    @article = Article.new
  end

  def edit
  end

  def create
    @article = Article.new(article_params)
    if @article.save
      flash[:notice] = "Article was created successfully."
      redirect_to @article
    else
      render 'new'
    end
  end

  def update
    if @article.update(article_params)
      flash[:notice] = "Article was updated successfully."
      redirect_to @article
    else
      render 'edit'
    end
  end

  def destroy
    @article.destroy
    redirect_to articles_path
  end

  private

  def set_article
    @article = Article.find(params[:id])
  end

  def article_params
    params.require(:article).permit(:title, :description)  #require the top level key and the keys you want to use in this instance object
  end

end
```
</details>
</details>

<details>
<summary>app/controllers/users_controller.rb</summary>

```ruby
class UsersController < ApplicationController

  def show
    @user = User.find(params[:id])
    @articles = @user.articles
  end

  def new
    @user = User.new
  end
  
  def create
    @user = User.new(user_params)
    if @user.save
      flash[:notice] = "Welcome to the Alpha Blog #{@user.username}, you have successfully signed up"
      redirect_to articles_path
    else
      render 'new'
    end
  end

  private
  def user_params
    params.require(:user).permit(:username, :email, :password)
  end

end
```
</details>
</details>

### Config
<details>
  <summary>config/routes.rb</summary>
  
```ruby
Rails.application.routes.draw do
  root 'pages#home'
  get 'about', to: 'pages#about'  #go to pages controller with about action
  resources :articles    #get all the routes available using keyword resources
  get 'signup', to: 'users#new' #go to users controller with new action
  resources :users, except: [:new]  #get all the routes available for users, we can do: post 'users', to: 'users#create'
end
```
</details>
  
