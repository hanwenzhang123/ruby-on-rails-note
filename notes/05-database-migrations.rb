- database can deine and traverse relationship between tables
- database issue commands to interact with the database
- database are optimized for working with data and relationship between data (not numbers like spreadsheet)
  
database: set of tables (collection), one database = one application
table: set of columns and rows, 1 table = 1 model, represents a single concept (products, customers)
column: set of data of a single simple type (first_name, email)
row: single record of data
field: intersection of a column and a row
index: data structure on a table to increase lookup speed
foreign key: table column whose values reference rows in another table
  
# Configure Project for a Database
  config/database.yml
  rails db:schema:dump
  
# Migration
  - set of database instructions
  - written in Ruby
  - "migrate" your database from one state to another
  - contains instructions for both:
    - moving up to a new state
    - moving back down to the previous state
    
# Why use Migrations?
- keep database schema with application code
- executable and repeatable
- allows sharing schema changes
- allows writing ruby instead of SQL
    
    
# Generate Migration
rails generate migration MigrationName
    
# Generate Model
rails generate model MigrationName #model name will be singular, while table name will be plural
    

A model is a class representation of a database column. 
A migration is the database table schema, it simply describes the database columns.
    
      
# Table Column Types
binary, boolean, date, datetime, decimal, float, integer, string, text, time
    
# Table Column Options
:limit => size
:default => value
:null => true/false
:precision => number
:scale => number
    
    
class CreateUsers < ActiveRecord::Migration[5.0]

  def up
    create_table :users do |t|  #t means table, rails will automatically generate the id for us, id => false turns off
      
      #add column definitions
      t.column "first_name", :string, :limit => 25
      t.string "last_name", :limit => 50
      t.string "email", :default => '', :null => false
      t.string "password", :limit => 40

      t.timestamps  #shortcut for below
      # t.datetime "created_at"
      # t.datetime "updated_at"
    end
  end

  def down
    drop_table :users   #drop the table
  end

end

    
# run a migration
rails db:migrate:status
rails db:migrate
rails db:migrate VERSION={versionID}
rails db:migrate:up
rails db:migrate:down
rails db:migrate:redo
  
  
# Table Migration Methods
create_table(table, options) do |t|
  ...columns...
end
drop_table(table)
rename_table(table, new_name)
    
# Column Migration Methods
add_column(table, column, type, options)
remove_column(table, column)
rename_column(table, column, new_name)
change_column(table, column, type, options)
    
# Index Migration Methods
add_index(table, column, option)
remove_index(table, column)
    
# Index Migration Method Options
:unique => true/false
:name => your_custom_name
    
# db/migrate/add_user_id_to_articles.rb
class AddUserIdToArticles < ActiveRecord::Migration[6.0]
    def change
      add_column :articles, :user_id, :int  #table name, field I want to add, type of the field I add
    end
end
    
# Quiz 
Which one of the following are a column migration method? add_column, rename_column, change_column
What is the mysql command to see the list of tables? SHOW TABLES;
Default the username to nothing and make sure it cannot be null. :default => '', :null => false
Migrations reside in the _____ directory. db
Migration contains instructions to only move forward to a new state. False, migrate your db from one state to another, moving up to a new state and down to previous state
To remove a database, you use _____. DROP DATABASE db_name
In the Employee table, FirstName represents a row. FALSE - column
    
    
# Example
class CreateUsers < ActiveRecord::Migration[5.0]

  def up
    create_table :users do |t|
      
      t.column "first_name", :string, :limit => 25
      t.string "last_name", :limit => 50
      t.string "email", :default => '', :null => false
      t.string "password", :limit => 40

      t.timestamps
      # t.datetime "created_at"
      # t.datetime "updated_at"
    end
  end

  def down
    drop_table :users
  end

end

class AlterUsers < ActiveRecord::Migration[5.0]

  def up
    rename_table("users", "admin_users")
    add_column("admin_users", "username", :string, :limit => 25, :after => "email")
    change_column("admin_users", "email", :string, :limit => 100)
    rename_column("admin_users", "password", "hashed_password")
    puts "*** Adding an index ***"
    add_index("admin_users", "username")
  end

  def down
    remove_index("admin_users", "username")
    rename_column("admin_users", "hashed_password", "password")
    change_column("admin_users", "email", :string, :default => '', :null => false)
    remove_column("admin_users", "username")
    rename_table("admin_users", "users")
  end

end


class CreateSubjects < ActiveRecord::Migration[5.0]

  def up
    create_table :subjects do |t|
      t.string "name"
      t.integer "position"
      t.boolean "visible", :default => false
      t.timestamps
    end
  end

  def down
    drop_table :subjects
  end

end

class CreatePages < ActiveRecord::Migration[5.0]

  def up
    create_table :pages do |t|
      t.integer "subject_id"
      t.string "name"
      t.string "permalink"
      t.integer "position"
      t.boolean "visible", :default => false
      t.timestamps
    end
    add_index("pages", "subject_id")
    add_index("pages", "permalink")
  end

  def down
    # don't need to drop indexes when dropping the whole table
    drop_table :pages
  end

end

class CreateSections < ActiveRecord::Migration[5.0]

  def up
    create_table :sections do |t|
      t.integer "page_id"
      t.string "name"
      t.integer "position"
      t.boolean "visible", :default => false
      t.string "content_type"
      t.text "content"
      t.timestamps
    end
    add_index("sections", "page_id")
  end

  def down
    # don't need to drop indexes when dropping the whole table
    drop_table :sections
  end

end 
     
