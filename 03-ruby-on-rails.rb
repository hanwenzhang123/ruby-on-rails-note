# views/layouts/application.html.erb
<body><%= yeild %></body> - all the view we create will be output at
        - whatever is in this file will show up on every single page
        
# config/locales/routes.rb - where your routes locate

controller - using plural like posts
model - using singular like post

# <%= %>  # we only use = here to output the variable


# generate the controller
rails g controller Posts (with the name of the controller)

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


  
