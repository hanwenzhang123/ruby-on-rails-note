Standard CRUB Actions
CRUD Action Description Example URL
Create  new     Display new record form   /subjects/new
        create  Process new record form   /subjects/create
Read    index   List records              /subjects
        show    Display a single record   /subjects/show/:id
Update  edit    Display edit record form  /subjects/edit/:id
        update  Process edit record form  /subjects/update/:id
Delete  delete  Display delete record form  /subjects/delete/:id
        destroy Process delete record form  /subjects/destroy/:id

# REST
- representational state transfer
- do not perform procedures
- perform state transformations upon resources
  
# HTTP Verbs
Verbs  Objective                          Usage   Multiple Request
GET    retrieve items from resources      links   yes
POST   create new item in resource        forms   no
PATCH  update existing item in resource   forms   yes
DELETE delete existing item in resource   forms   yes

  
# Resourceful URL Helpers
HTTP Verb   URL             Action    URL Helper
GET        /subjects        index     subjects_path
GET        /subjects/:id    show      subject_path(:id)
GET        /subjects/new    new       new_subject_path
POST       /subjects         create    subject_path
GET        /subjects/:id/edit  edit    edit_subject_path(:id)
PATCH      /subjects/:id       update    subject_path(:id)
GET       /subjects/:id/delete   delete    delete_subject_path(:id)
DELETE    /subjects/:id         destroy    subject_path(:id)
  
<%= link_to("All Subjects", subjects_path) %>
<%= link_to("All Subjects", subjects_path(:page => 3)) %>
<%= link_to("Show Subject", subject_path(@subject.id)) %>
<%= link_to("Show Subject", subject_path(@subject.id, :format => "verbose")) %>
<%= link_to("Edit Subject", edit_subject_path(@subject.id)) %>
  
#Quiz
For the index action of the GET verb, the URL helper is _____. subjects_path
What is the benefit of using resourceful routes? Improves application security, Organized structure, Optimized for REST
The REST verb that is not use with forms is _____. GET
In Rails, what is the action to process delete record form? destroy
  
The index action displays a list of records.
The show action displays a single records.
The form _____ is where the form submits its data. action
The create part of CRUD is made up of two standard actions, _____ and _____. new, create
_____ is a method that marks the attributes as being available for mass assignment. Permit
  
  
#Controller
rails generate controller Pages index show new edit delete
  
  
# Mass Assignment
Rails term for passing a hash of values to an object to be assigned as attributes
Subject.new(params[:subject])
Subject.create(params[:subject])
@subject.update_attributes(params[:subject])
  
# Mass Assignment Filtering  => strong parameters
params.permit(:first_name, :last_name)
params.require(:subject)  #returns :subject hash, similar to params[:subject]
params.require(:subject).permit(:name, :position, :visible)
 
  
#SubjectsController
class SubjectsController < ApplicationController

  def index
    @subjects = Subject.sorted
  end

  def show
    @subject = Subject.find(params[:id])
  end

  def new
    @subject = Subject.new({:name => 'Default'})
  end

  def create
    # Instantiate a new object using form parameters
    @subject = Subject.new(subject_params)
    # Save the object
    if @subject.save
      # If save succeeds, redirect to the index action
      flash[:notice] = "Subject created successfully."
      redirect_to(subjects_path)
    else
      # If save fails, redisplay the form so user can fix problems
      render('new')
    end
  end

  def edit
    @subject = Subject.find(params[:id])
  end

  def update
    # Find a new object using form parameters
    @subject = Subject.find(params[:id])
    # Update the object
    if @subject.update_attributes(subject_params)
      # If save succeeds, redirect to the show action
      flash[:notice] = "Subject updated successfully."
      redirect_to(subject_path(@subject))
    else
      # If save fails, redisplay the form so user can fix problems
      render('edit')
    end
  end

  def delete
    @subject = Subject.find(params[:id])
  end

  def destroy
    @subject = Subject.find(params[:id])
    @subject.destroy
    flash[:notice] = "Subject '#{@subject.name}' destroyed successfully."
    redirect_to(subjects_path)
  end

  private

  def subject_params
    params.require(:subject).permit(:name, :position, :visible)
  end

end

  
# PagesController
class PagesController < ApplicationController

  def index
    @pages = Page.sorted
  end

  def show
    @page = Page.find(params[:id])
  end

  def new
    @page = Page.new
  end

  def create
    @page = Page.new(page_params)
    if @page.save
      flash[:notice] = "Page created successfully."
      redirect_to(pages_path)
    else
      render('new')
    end
  end

  def edit
    @page = Page.find(params[:id])
  end

  def update
    @page = Page.find(params[:id])
    if @page.update_attributes(page_params)
      flash[:notice] = "Page updated successfully."
      redirect_to(page_path(@page))
    else
      render('edit')
    end
  end

  def delete
    @page = Page.find(params[:id])
  end

  def destroy
    @page = Page.find(params[:id])
    @page.destroy
    flash[:notice] = "Page destroyed successfully."
    redirect_to(pages_path)
  end

  private

  def page_params
    params.require(:page).permit(:subject_id, :name, :position, :visible, :permalink)
  end

end

  
# SectionsController
class SectionsController < ApplicationController

  def index
    @sections = Section.sorted
  end

  def show
    @section = Section.find(params[:id])
  end

  def new
    @section = Section.new
  end

  def create
    @section = Section.new(section_params)
    if @section.save
      flash[:notice] = "Section created successfully."
      redirect_to(sections_path)
    else
      render('new')
    end
  end

  def edit
    @section = Section.find(params[:id])
  end

  def update
    @section = Section.find(params[:id])
    if @section.update_attributes(section_params)
      flash[:notice] = "Section updated successfully."
      redirect_to(section_path(@section))
    else
      render('edit')
    end
  end

  def delete
    @section = Section.find(params[:id])
  end

  def destroy
    @section = Section.find(params[:id])
    @section.destroy
    flash[:notice] = "Section destroyed successfully."
    redirect_to(sections_path)
  end

  private

  def section_params
    params.require(:section).permit(:page_id, :name, :position, :visible, :content_type, :content)
  end

end

  
  
# Model
class Section < ApplicationRecord

  belongs_to :page
  has_many :section_edits
  has_many :admin_users, :through => :section_edits

  scope :visible, lambda { where(:visible => true) }
  scope :invisible, lambda { where(:visible => false) }
  scope :sorted, lambda { order("position ASC") }
  scope :newest_first, lambda { order("created_at DESC") }

end

class Page < ApplicationRecord

  belongs_to :subject, { :optional => false }
  has_many :sections
  has_and_belongs_to_many :admin_users

  scope :visible, lambda { where(:visible => true) }
  scope :invisible, lambda { where(:visible => false) }
  scope :sorted, lambda { order("position ASC") }
  scope :newest_first, lambda { order("created_at DESC") }

end

  
#routes.db
Rails.application.routes.draw do

  root 'demo#index'

  resources :subjects do
    member do
      get :delete
    end
  end

  resources :pages do
    member do
      get :delete
    end
  end

  resources :sections do
    member do
      get :delete
    end
  end

  get 'demo/index'
  get 'demo/hello'
  get 'demo/other_hello'
  get 'demo/lynda'

  # default route
  # may go away in future versions of Rails
  # get ':controller(/:action(/:id))'

  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end

  
