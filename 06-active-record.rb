- active record: design pattern for relational database
- ActiveRecord: Rails implementation of active record pattern
- Retrieve and manipulate data as objects, not as static row
  
# ActiveRecord Example
user = User.new
user.first_name = "Kevin"
user.save
  
user.last_name = "Allan"
user.save
  
user.delete
  
# What is ActiveRelation?
- Known as "ARel"
- Object oriented interpretation of relational algebra
- simplifies the generation of complex database queries
  - small queries are chainable (like most Ruby objects)
  - complex joins and aggregations use efficient SQL
  - queries do not execute until needed
  
# ActiveRelation Example
users = User.where(:first_name => "Kevin")
users = Users.order("last_name ASC").limit(5)

SELECT users.* FROM users
WHERE users.first_name = "Kevin"
ORDER BY users.last_name ASC
LIMIT 5
    
    
# Generating a Model
Command line, from the root of Rails application
    rails generate model SingularName(Subject)
Creates file in db/migrate
    File name: timestamp_create_subjects.rb
    Class name: CreateSubjects
    create_table :subjects
    drop_table :subjects
Creates file in app/models
    File name: subject.rb
    Class name: Subject

# Names Matter
Table names
File names
Class names
    
    
# Rails Console
rails c
    
# Create
subject = Subject.new
subject.new_record?  #true
subject.name = "first subject"
subject.name  #first subject
subject = Subject.new(:name => "First Subject", :position => 1, :visible => true) #same as above
subject.save  #save in the database    
subject.new_record?  #false
subject.id  #1 - primary key
subject.created_at  #set automatically
subject = Subject.create(:name => "Second Subject", :position => 2)  #create automatically
    
# Update
subject = Subject.find(1) #pass the ID (primary key) we want to find 
subject.new_record?  #false
subject.name  #first subject
subject.name = "initial subject"
subject.name  #initial subject
subject.save  #save seperately
subject.update_attributes(:name => "Next Subject", :visible => true) #set values and save at the same time.
    
# Delete
subject = Subject.create(:name => "bad subject")
subject = Subject.find(3)
subject.destroy
    
# Find
- primary key finder: Subject.find(2)
- dynamic finder: Subject.find_by_id(2)
        Subject.find_by_name("first subject")
- find all: Subject.all
- find first/last: Subject.first, Subject.last
    

# Query methods: conditions
where(conditions): Subject.where(:visible => true)
condition express type: string, array, hash
- string: "name="Test" AND visible=true", flexible, be aware of SQL injection
- array: ["name =? AND visible=true", "Test"] - flexible, safe from SQL injection
- hash: {:name => "Test, :visible => true} - safe from SQL injection, each pair joined with AND
    
return and ActiveRelation which can be chained
User.where(:last_name => "Smith").where(:first_name => "John") => command does not happen right away
Subject.where(:visible => true)
Subject.class
Subject.to_sql
Subject.where(:position => 1, :visible => true)


# Order
order(string
order(:position)
order("position")
order(:position => :asc)
order("position ASC")
order(:position => :desc)
order("position DESC")

# Limit
limit(integer) - up to a certain number of records
Subject.limit(5)

# Offset
offset(integer) - scape over records
Subject.where(:visible => true).order(:position => :asc).limit(20).offset(40)
    
    
# Named Scopes
- queries defined in a model
- defined using ActiveRelation query methods
- can be called like ActiveRelation methods
- cam accept parameters
- Rails 5 requires lambda syntax

scope :active, lambda {where(:active => true)}
scope :active, -> {where(:active => true)}

def self.active
  where(:active => true)
end

def :with_content_type, lambda {|ctype|
  where(:content_type => ctype)
}
def self.with_content_type(ctype)
  where(:content_type => ctype)
}
end
Section.with_content_type("html")

# Evaluated when called, not when defined
scope :recent, lambda {
  where(:created_at => 1.week.ago..Time.now)
}

# Chaining scope
Article.recent.visible.newest_first

class Subject < ApplicationRecord
  scope :visible, lambda {where(:visible => true)}
  scope :invisible, lambda {where(:visible => false)}
  scope :sorted, lambda {order("position ASC")}
  scope :newest_first, lambda {order("created_at DESC")}
  scope :search, lambda {|query| where(["name LIKE ?", "%#{query}%"])}  #%% is wildcard, query will be placed in the spot ?
end

Subject.search("Initial") #return the subject name contains "Initial"


# Quiz
Subject.find_by_id(5) returns _____. object or nil
_____ bypasses some Rails features and might give you unexpected behavior. Delete. So use Destroy to delete
With update_attributes, you can set values and save at the same time.
You can use _____ to instantiate a new object, sets its value, and save. create
The "rails c" command will default to the _____ environment. development
The following will allow me to read and write the employee_name. attr_accessor :employee_name
ActiveRecord is the Rails implementation of active record pattern.

