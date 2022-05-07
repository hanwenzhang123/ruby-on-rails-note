rails generate controller demo index

# controller/demo_controller.rb
class DemoController < ApplicationController
        def index
        end
end

# views/demo/index.html.erb     
=> folder name correspond to the controller name
=> view template name correspond to the action

# config/routes.rb
Rails.application.routes.draw do
        get "demo/index"
end
# public directory
=> will return from public directory other than going to the rail app


# Rails Architecture
broswer - web server - public - routing
                 \                 |
                  \            controller
                   \             |   |
                      -------- view model - database

# Route Types
- simple match route
  get "demo/index"
  match "demo/index", :to => "demo#index",
    :via => :get
- default route
  :controller/:action/:id
  get ":controller(/:action(/:id))"
- root route
  match "/", :to => "demo#index", :via => :get
  root "demo#index"
- resourceful routes


When we talk about data objects, we are mostly referring to Model
Ruby version 5 was released in 2016. Rails is a web application framework. DRY stands for Do not Repeat Yourself.
In the routing snippet below :to => "A#B", A is controller
A request goes to Rails routing, and routing parses the URL to determine which controller and action to use.
The item that you can generate with the command "rails generate" is controller model helper
Which command stops the web server? Control+C
Which command starts the web server? rails s
Which directory will you spend most of your time in? app
What command should you run after changes in the Gemfile? bundle install
What option should you use to configure the rails application to use MySQL database? -d mysql
- rails new simple_cms -d mysql (specify for the use for config mysql)
- mysql -u root -p   (config db)
- CREATE DATABASE simple_cms_development
- CREATE DATABASE simple_cms_test
- GRANT ALL PRIVILEGES ON simple_cms_development.* TO "rails_user"@"localhost" IDENTIFIED BY "secretpassword"
        
        
# views/layouts/application.html.erb
<body><%= yeild %></body> - all the view we create will be output at
        - whatever is in this file will show up on every single page
        
# config/locales/routes.rb - where your routes locate

controller - using plural like posts
model - using singular like post

# <%= %>  # we only use = here to output the variable


# generate the controller
rails g controller Posts (with the name of the controller)

# show all the routes
rake routes 


# attends using <
# all the controller should extends ApplicationController
class PostsController < ApplicationController
  def index     # the way how ruby declares function
    @posts = Post.all   #get all posts
  end
  def show
    @post = Post.find(params[:id])  #get the single post based on id
  end
  def new   #take care the new form
    
  end
  def create 
    # render plain: params[:post].inspect
    # @post = Post.new(params[:post])
    @post = Post.new(post_params)   #we use the method we declared below
    @post.save  #save method to save
    redirect_to @post
  end
  private def post_params
    params.require(:post).permit(:title, :body)
  end
end

#view
# views/pages/new.html.erb
<h1>Add Post</h1>
  <%= form_for :post, url: posts_path do |f| %>  #form is for post, data goes to posts_path, f is used down in the code create f.label etc
  <p>
    <%= f.label :title %><br>
    <%= f.text_field :title %><br>
  </p>
  <p>
    <%= f.label :body %><br>
    <%= f.text_area :body %><br>
  </p>
  <p>
    <%= f.submit %>   #get submitted to the create method above in an object
  </p> 
# <% end %>

#routes
# you can have the root of your site routed with "root"
root "posts#index"  # posts index template to be the root view, posts controller

    
# generate the show view
    # views/pages/show.html.erb
<h2><%= @post.title %></h2>
<p><%= @post.body %></p>
    

# generate the controller
rails g controller Pages
class PostsController < ApplicationController
  def about
    @title = "About Us";    #send data from controller to the view
    @content = "About Us Page";
  end
end

#view
# views/pages/about.html.erb
<h1><%= @title % /></h1>
<p><%= @content % /></p>
  
#routes
# example of a regular route:
get "about" => "pages#about" #get request where goes to the pages controller and the about view

# example resource route (maps HTTP verbs to controller actions)
resources :posts

#terminal
- rake routes # show all the routes for the application


# generate the controller
rails g model Post title:string body:text   #create a model file for us

rake db: migrate    # create the table

  
