---
title: Ruby-on-Rails Notes
---

## Rails Commands
### Examples
  
```ruby
- `rails new my-app` - generate a new project
- `rails server`, `rails s` - rails server
- `rails console`, `rails c` - rails console
- `reload!` - reload the console
- `rails routes --expanded` - check routes presented in a viewer-friendly way
- `rails routes --expanded | grep edit` - show the routes with the keyword edit
- `rails generate controller message create` - create a message controller
- `rails destroy controller message` - undo the message controller that was created
- `rails generate migration name_of_migration_file` - generate migration
- `rails generate migration create_articles` - generate a migration to create an Article table
- `rails generate migration add_admin_to_users` - generate a migration to add admin fields (columns) to users
- `rails generate migration add_user_id_to_articles` - generate a migration to add the user_id column to articles table
- `rails db:migrate` - run the migration file
- `rails db:rollback` - rollback or undo the changes made by the last migration
- `rails generate controller pages` - create a pages controller 
- `rails g model Post title:string body:text` - create a model file for us
- `rails generate scaffold Article title:string description:text` - to create an article model (with two attributes), articles controller, views for articles and migration file to create articles table
- `rails generate migration add_password_digest_to_users` - create a migration file to add the password_digest column to the users table
- `rails g resource UserStock user:references stock:references` - many to many association, tables user primary id and stock primary id fields which will be used as foreign keys
```

## Data Attributes
### Type of the Data Attributes
  
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
- `ModalName.toggle!(field)` - `user.toggle!(:admin)`
- `user.stocks << stock` - add that stock as a reference to user.stocks (many to many relationship)
- `user.stocks.count` - count how many
</details>

<details>
  <summary>app/models/article.rb</summary>

```ruby
class Article < ApplicationRecord
  belongs_to :user  #association, singular since article can only belong to one user
  has_many :article_categories
  has_many :categories, through: :article_categories
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
  has_many :articles， dependent: :destroy  #association, dependent will be destroyed if the user is deleted
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
  <summary>app/models/category.rb</summary>

```ruby
class Category < ApplicationRecord
  validates :name, presence: true, length: { minimum: 3, maximum: 25 }
  validates_uniqueness_of :name
  has_many :article_categories
  has_many :articles, through: :article_categories
end
```
</details>

<details>
  <summary>app/models/article_category.rb </summary>

```ruby
class ArticleCategory < ApplicationRecord
  belongs_to :article
  belongs_to :category
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
```ruby
#rails generate migration add_admin_to_users 
#rails console => user.toggle!(:admin)
class AddAdminToUsers < ActiveRecord::Migration[6.0]
  def change
    add_column :users, :admin, :boolean, default: false
  end
end
```
```ruby
#rails generate migration create_categories
class CreateCategories < ActiveRecord::Migration[6.0]
  def change
    create_table :categories do |t|
      t.string :name
      t.timestamps
    end
  end
end
```
```ruby
#rails generate migration create_article_categories
class CreateArticleCategories < ActiveRecord::Migration[6.0]
  def change
    create_table :article_categories do |t|
      t.integer :article_id
      t.integer :category_id
    end
  end
end
```
</details>

<details>
  <summary>db/schema.rb</summary>
  
```ruby
ActiveRecord::Schema.define(version: 2020_05_19_124121) do

  create_table "article_categories", force: :cascade do |t|
    t.integer "article_id"
    t.integer "category_id"
  end

  create_table "articles", force: :cascade do |t|
    t.string "title"  #add attributes for the table in the migration file
    t.text "description"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer "user_id"
  end

  create_table "categories", force: :cascade do |t|
    t.string "name"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
  end

  create_table "users", force: :cascade do |t|
    t.string "username"
    t.string "email"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.string "password_digest"
    t.boolean "admin", default: false
  end

end
```
</details>
</details>
</details>


### Controller
<details>
  <summary>app/controllers/application_controller.rb => controller methods as helper methods</summary>
  
```ruby
class ApplicationController < ActionController::Base
  helper_method :current_user, :logged_in?

  def current_user
    @current_user ||= User.find(session[:user_id]) if session[:user_id]
  end

  def logged_in?
    !!current_user
  end

  def require_user
    if !logged_in?
      flash[:alert] = "You must be logged in to perform that action"
      redirect_to login_path
    end
  end

end
```

```ruby
class ApplicationController < ActionController::Base
  def current_user
    return unless session[:user_id]
    @current_user ||= User.find(session[:user_id])
  end
end
```
</details>
</details>
  
<details>
  <summary>app/controllers/articles_controller.rb</summary>
  
```ruby
class ArticlesController < ApplicationController
  before_action :set_article, only: [:show, :edit, :update, :destroy]
  before_action :require_user, except: [:show, :index]
  before_action :require_same_user, only: [:edit, :update, :destroy]

  def show
    # @article = Article.find(params[:id])  # params that sends in the id in hash format, no needs this line due to before_action
  end
  
  def index
    @articles = Article.paginate(page: params[:page], per_page: 5)  # pagination
    # @articles = Article.all  #save values to an instance variable
  end

  def new
    @article = Article.new
  end

  def edit
  end

   def create
    @article = Article.new(article_params)
    @article.user = current_user
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
    params.require(:article).permit(:title, :description, category_ids: [])  #require the top level key and the keys you want to use in this instance object
  end

  def require_same_user
    if current_user != @article.user && !current_user.admin?
      flash[:alert] = "You can only edit or delete your own article"
      redirect_to @article
    end
  end

end
```
</details>
</details>

<details>
<summary>app/controllers/users_controller.rb</summary>

```ruby
class UsersController < ApplicationController
  before_action :set_user, only: [:show, :edit, :update, :destroy]
  before_action :require_user, only: [:edit, :update]
  before_action :require_same_user, only: [:edit, :update, :destroy]

  def show
    @articles = @user.articles.paginate(page: params[:page], per_page: 5)
  end

  def index
    @users = User.paginate(page: params[:page], per_page: 5)
  end

  def new
    @user = User.new
  end

  def edit
  end

  def update
    if @user.update(user_params)
      flash[:notice] = "Your account information was successfully updated"
      redirect_to @user
    else
      render 'edit'
    end
  end

  def create
    @user = User.new(user_params)
    if @user.save
      session[:user_id] = @user.id
      flash[:notice] = "Welcome to the Alpha Blog #{@user.username}, you have successfully signed up"
      redirect_to articles_path
    else
      render 'new'
    end
  end

  def destroy
    @user.destroy
    session[:user_id] = nil if @user == current_user
    flash[:notice] = "Account and all associated articles successfully deleted"
    redirect_to articles_path
  end

  private
  def user_params
    params.require(:user).permit(:username, :email, :password)
  end

  def set_user
    @user = User.find(params[:id])
  end

  def require_same_user
    if current_user != @user && !current_user.admin?
      flash[:alert] = "You can only edit or delete your own account"
      redirect_to @user
    end
  end
  
end
```
</details>
</details>

<details>
<summary>app/controllers/sessions_controller.rb</summary>

```ruby
class SessionsController < ApplicationController

  def new
  end

  def create
    user = User.find_by(email: params[:session][:email].downcase)
    if user && user.authenticate(params[:session][:password])
      session[:user_id] = user.id
      flash[:notice] = "Logged in successfully"
      redirect_to user
    else
      flash.now[:alert] = "There was something wrong with your login details"
      render 'new'
    end
  end

  def destroy
    session[:user_id] = nil
    flash[:notice] = "Logged out"
    redirect_to root_path
  end

end
```
</details>
</details>

<details>
<summary>app/controllers/categories_controller.rb </summary>

```ruby
class CategoriesController < ApplicationController
  before_action :require_admin, except: [:index, :show]

  def new
    @category = Category.new
  end

  def create
    @category = Category.new(category_params)
    if @category.save
      flash[:notice] = "Category was successfully created"
      redirect_to @category
    else
      render 'new'
    end
  end

  def edit
    @category = Category.find(params[:id])
  end

  def update
    @category = Category.find(params[:id])
    if @category.update(category_params)
      flash[:notice] = "Category name updated successfully"
      redirect_to @category
    else
      render 'edit'
    end
  end

  def index
    @categories = Category.paginate(page: params[:page], per_page: 5)
  end

  def show
    @category = Category.find(params[:id])
    @articles = @category.articles.paginate(page: params[:page], per_page: 5)
  end
  
  private

  def category_params
    params.require(:category).permit(:name)
  end

  def require_admin
    if !(logged_in? && current_user.admin?)
      flash[:alert] = "Only admins can perform that action"
      redirect_to categories_path
    end
  end
end
```
</details>
</details>
  
### View
  <details>
  <summary>app/views/users/_form.html.erb</summary>
  
```ruby
<div class="container">
  <div class="row justify-content-center">
    <div class="col-10">
      <%= render 'shared/errors', obj: @user %>
      <%= form_with(model: @user, class: "shadow p-3 mb-3 bg-info rounded", local: true) do |f| %>
        <div class="form-group row">
          <%= f.label :username, class: "col-2 col-form-label text-light" %>
          <div class="col-10">
            <%= f.text_field :username, class: "form-control shadow rounded", placeholder: "Enter a username" %>
          </div>
        </div>

        <div class="form-group row">
          <%= f.label :email, class: "col-2 col-form-label text-light" %>
          <div class="col-10"> 
            <%= f.email_field :email, class: "form-control shadow rounded", placeholder: "Enter your email address" %>
          </div>
        </div>

        <div class="form-group row">
          <%= f.label :password, class: "col-2 col-form-label text-light" %>
          <div class="col-10"> 
            <%= f.password_field :password, class: "form-control shadow rounded", placeholder: "Choose a password" %>
          </div>
        </div>

        <div class="form-group row justify-content-center">
          <%= f.submit(@user.new_record? ? "Sign up" : "Update account", class: "btn btn-outline-light btn-lg") %>
        </div>
      <% end %>
    </div>
    <div class="mb-3">
      <%= link_to '[ Cancel and return to articles listing ]', articles_path, class: "text-info" %>
    </div>
  </div>
</div>
```
</details>
</details>
          
<details>
  <summary>app/views/sessions/new.html.erb</summary>
  
```ruby
<h1 class="text-center mt-4">Log in</h1>

<div class="container">
  <div class="row justify-content-center">
    <div class="col-10">
      <%= form_with(scope: :session, url: login_path, class: "shadow p-3 mb-3 bg-info rounded", local: true) do |f| %>  #using scope since we do not deal with modal, url for post route
        <div class="form-group row">
          <%= f.label :email, class: "col-2 col-form-label text-light" %>
          <div class="col-10"> 
            <%= f.email_field :email, class: "form-control shadow rounded", placeholder: "Enter your email address" %>
          </div>
        </div>

        <div class="form-group row">
          <%= f.label :password, class: "col-2 col-form-label text-light" %>
          <div class="col-10"> 
            <%= f.password_field :password, class: "form-control shadow rounded", placeholder: "Enter your password" %>
          </div>
        </div>

        <div class="form-group row justify-content-center">
          <%= f.submit "Log in", class: "btn btn-outline-light btn-lg" %>
        </div>
      <% end %>
    </div>
    <div class="mb-3">
      <%= link_to '[ Cancel and return to articles listing ]', articles_path, class: "text-info" %>
    </div>
  </div>
</div>
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
  get 'login', to: 'sessions#new' #get the login path, send to session controller new action
  post 'login', to: 'sessions#create' #post to the login path, send to session controller create action
  delete 'logout', to: 'sessions#destroy' #delete request
  resources :categories, except: [:destroy]
end
```
</details>
  
### Helper
<details>
  <summary>app/helpers/application_helper.rb</summary>
  
```ruby
module ApplicationHelper
  def gravatar_for(user, options = { size: 80})   # <%= gravatar_for @user, size: 200 %>
    email_address = user.email.downcase
    hash = Digest::MD5.hexdigest(email_address)
    size = options[:size]
    gravatar_url = "https://www.gravatar.com/avatar/#{hash}?s=#{size}"
    image_tag(gravatar_url, alt: user.username, class: "rounded shadow mx-auto d-block")
  end
end
```
</details>
  
