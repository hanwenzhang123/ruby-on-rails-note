# One to One Association
- Unique items a person or thing can only have one of
  Employee has_one :office
  Student has_one :id_card
- Sometimes used to break up a single table
  Customer has_one :billing_address
  Stage has_one :lighting_configuration

Subject-Page
Subject has_one :page
Page belongs_to :subject

# Tips!
Class with "belongs_to" has the foreign key
Always define both sides of the relationship

subject.page
subject.page = page

page.subject
page.subject = subject


# One to Many Association
- more commonly used
- plural relationship names
- return an array of objects instead of a single object
- used when an object has many objects which belongs to it exclusively

Subject has_many :pages
Page belongs_to :subject

subject.pages
subject.pages << page
subject.pages = [page, page, page]
subject.pages.delete(page)
subject.pages.destroy(page)
subject.pages.clear
subject.pages.empty?
subject.pages.size


# Many to Many Association: Simple
- used when an object has many objects that belong to it but not exclusively
Project has_and_belongs_to_mang :collaborators
BlogPost has_and_belongs_to_mang :categories
- Requires a join table
- Two foreign keys; index both keys together
- No primary key column (:id => false)
- Add same instance methods to the class
AdminUser has_and_belongs_to_mang :pages
Page has_and_belongs_to_mang :admin_users
  

# Join Table Naming
first_table + _ + second_table
  - plural table names
  - alphabetical order
  - default name; can be configured
  
  
# Many to Many Association: Rich
- still uses a join table with two indexed foreign keys
- requires a primary key column(:id)
- join table has its own model
- no table name conventions to follow
- names ending in "-ments" or "-ships" work well
  
  
class CreateSectionEdits < ActiveRecord::Migration[5.0]
  def up
    create_table :section_edits do |t|
      t.integer "admin_user_id"
      t.integer "section_id"
      t.string "summary"
      t.timestamps
    end
    add_index("section_edits", ['admin_user_id', 'section_id'])
  end
  def down
    drop_table :section_edits
  end
end
  
class AdminUser < ApplicationRecord
  has_and_belongs_to_many :pages
  has_many :section_edits
  has_many :sections, :through => :section_edits
end

class ApplicationRecord < ActiveRecord::Base
  self.abstract_class = true
end

class Page < ApplicationRecord
  belongs_to :subject, { :optional => false }
  has_many :sections
  has_and_belongs_to_many :admin_users
end
  
class SectionEdit < ApplicationRecord
  belongs_to :admin_user
  belongs_to :section
end
  
class Section < ApplicationRecord
  belongs_to :page
  has_many :section_edits
  has_many :admin_users, :through => :section_edits
end

class Subject < ApplicationRecord
  has_many :pages
  scope :visible, lambda { where(:visible => true) }
  scope :invisible, lambda { where(:visible => false) }
  scope :sorted, lambda { order("position ASC") }
  scope :newest_first, lambda { order("created_at DESC") }
  scope :search, lambda {|query| where(["name LIKE ?", "%#{query}%"]) }
end

  
# Quiz
Which one of the following is not a many-to-many association? book and chapter
In Rails 5.0, an object that had a belongs to relationship could be saved to the database even if it did not have a parent object associated with it.
_____ is a one-to-many association. Department and employees
_____ is an invalid association. Many-to-none
many-to-many association: project and collaborators, student and course, blog post and categories, Order and order detail, Employee and computer, Student and course

   
