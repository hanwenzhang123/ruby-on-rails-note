#render a template
render template syntax
- render(:template => "demo/hello")
- render("demo/hello")
- render("hello")

#config.routes.db
Rails.application.routes.draw do
  root "demo#index"
  get "demo/index"
  get "demo/hello"
end

# app/controllers/demo_controller.rb
class DemoController < ApplicationController
  def index
    render("demo/index")
  end
  def hello
    @array = [1, 2, 3, 4, 5]  #instance vairable
    @id = params['id']
    @page = params[:page]
    render("demo/hello")
  end
  def other_hello   #redirect actions
    redirect_to(:action => "index")
  end
  def lynda
    redirect_to('http://lynda.com')
  end
end

# app/views/demo/hello.html.erb
# <h1>Hello world from Hello</h1>
# views/demo/index.html.erb
# <h1>Hello world from Index</h1>
  

# view templates
# What is ERB?
- "Embedded Ruby"
- eRuby templating system to embed Ruby

# Template File Naming
- hello.html.erb
  template name: hello
  process with: erb
  output format: html

# embedding ruby in an ERB
  <% code %>  #no output - process and execute ruby code
  <%= code %> #has output - execute ruby code, then output whatever result that code returns into our template. 

<%= 1+1 %> #2
<% target = "world" %>
<%= "Hello #{target}" %> #Hello World
<% 3.times do |n| %>
  <%= n %>  #0 1 2
<% end %>

# instance variables
variable
@instance_variable

# controller
  def hello
    @array = [1, 2, 3, 4, 5]  #instance vairable
    render("demo/hello")
  end

# view
<% @array.each do |n| %>
  <%= n %>  #0 1 2
<% end %>


#links
<%= link_to(text, target) %>

# link targets
"/demo/index"
{:controller => "demo", :action => "index"}

<a href="/demo/hello">Hello page 1</a><br />  #html links
<%= link_to('Index page', {:action => 'index'}) %><br />  #will be localhost:3000 due to shorter route in the route file
<%= link_to('Hello page 2', {:action => 'hello'}) %><br />


# url parameter
# html link with parameters
/demo/hello/1?page=3&name=kevin

# access parameter values
params[:id]
params["id"]

<%= link_to('Hello with parameters', {:action => 'hello', :page => 5, :id => 20}) %><br />
# localhost: 3000/demo/hello?id=20&page=5

  def hello
    @array = [1, 2, 3, 4, 5]  #instance vairable
    @id = params['id']
    @page = params[:page]
    render("demo/hello")
  end

ID: <%= @id %><br />
ID: <%= params[:id] %><br />
Page: <%= @page %><br />
Next page: <%= @page.to_i + 1 %><br />  #params always string


In a URL the key value pairs in the parameter are separated by &
To create a link in Rails, you use the _____ method. link_to
Instance variables are preceded by @
_____ executes the Ruby code, then output whatever result that code returns into the template. <%= code %>
The correct code for a redirect is _____. 302
If you want to tell rails what template to use, you indicate that using _____. render

 



