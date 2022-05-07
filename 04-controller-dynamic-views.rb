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
    render("demo/hello")
  end
  def other_hello   #redirect actions
    redirect_to(:action => "index")
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
<% @array.each do |n| %>
  <%= n %>  #0 1 2
<% end %>

#instance variables
variable
@instance_variable



#links

#url parameter
