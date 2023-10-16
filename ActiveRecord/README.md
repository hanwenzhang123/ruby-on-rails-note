---
title: Ruby-on-Rails ActiveRecord
---

## Basics
Active Record is the M in MVC - the model - which is responsible for representing business data and logic that ensures both persistent data and behavior on how to write to and read from the database.

Object Relational Mapping - Active Record as an ORM Framework, a technique that connects objects of an application to a table without writing SQL in a relational database management system

#### Naming Convention 
Used for creating a mapping between models and database tables, Rails will pluralize your class names to find the respective database table. 

- Model Class - Singular with CamelCase (e.g., Article, BookClub, LineItem, Mouse, Person).
Database Table / Schema - Plural with snake_case (e.g., articles, book_clubs, line_items, mice, people).

#### Schema Convention 
Used for the columns in the database table

- Primary keys - By default, Active Record will use an integer column named id as the table's primary key, automatically created when created tables via Active Record Migration.
- Foreign keys - Named following the pattern singularized_table_name_id (e.g., item_id, order_id), will look for when you create associations between your models.
- Optional column names that will add additional features to Active Record instances:
  - created_at - Automatically gets set to the current date and time when the record is first created.
  - updated_at - Automatically gets set to the current date and time whenever the record is created or updated.
  - lock_version - Adds optimistic locking to a model.
  - type - Specifies that the model uses Single Table Inheritance.
  - (association_name)_type - Stores the type for polymorphic associations.
  - (table_name)_count - Used to cache the number of belonging objects on associations. 

## Creating Models
To create Active Record models, subclass the ApplicationRecord class. This will create a Product model, mapped to a products table at the database.

```ruby
class Product < ApplicationRecord
  self.table_name = "my_products" # Overriding the Naming Conventions
  self.primary_key = "product_id"
  # ...
end

class ProductTest < ActiveSupport::TestCase
  set_fixture_class my_products: Product
  fixtures :my_products
  # ...
end
```

## Creating Models
To create Active Record models, subclass the ApplicationRecord class. This will create a Product model, mapped to a products table at the database.

```ruby
class Product < ApplicationRecord
  self.table_name = "my_products" # Overriding the Naming Conventions
  self.primary_key = "product_id"
  # ...
end

class ProductTest < ActiveSupport::TestCase
  set_fixture_class my_products: Product
  fixtures :my_products
  # ...
end
```

## CRUD

#### Create
```ruby
user = User.create(name: "David", occupation: "Code Artist")

user = User.new
user.name = "David"
user.occupation = "Code Artist"

user = User.new do |u|
  u.name = "David"
  u.occupation = "Code Artist"
end
```

#### Read
```ruby
users = User.all
user = User.first
user = User.last
david = User.find_by(name: 'David')
users = User.where(name: 'David', occupation: 'Code Artist').order(created_at: :desc)
```

#### Update
```ruby
user = User.find_by(name: 'David')
user.name = 'Dave'
user.save

user = User.find_by(name: 'David')
user.update(name: 'Dave')

User.update_all "max_login_attempts = 3, must_change_password = 'true'"

User.update(:all, max_login_attempts: 3, must_change_password: true)
```

#### Delete
```ruby
user = User.find_by(name: 'David')
user.destroy
User.destroy_by(name: 'David')
User.destroy_all
```

## Validations
```ruby
class User < ApplicationRecord
  validates :name, presence: true
end
```

## Callback
```ruby
class User < ApplicationRecord
  validates :login, :email, presence: true

  before_validation :ensure_login_has_a_value

  before_create do
    self.name = login.capitalize if name.blank?
  end

  before_validation :normalize_name, on: :create

  after_validation :set_location, on: [ :create, :update ]

  private
    def ensure_login_has_a_value
      if login.nil?
        self.login = email unless email.blank?
      end
    end

    def normalize_name
      self.name = name.downcase.titleize
    end

    def set_location
      self.location = LocationService.query(self)
    end
end
```

## Migrations
Migrationalter your database schema over time as a new version, allowing your schema and changes to be database independent.

```ruby
class Create < ActiveRecord::Migration[7.0]
  def change
    create_table :products do |t|
      t.string :name
      t.text :description
      t.timestamps
    end
    add_column :products, :part_number, :string
    add_column :products, :price, :decimal
    add_reference :products, :user, foreign_key: true
  end
end

class Change < ActiveRecord::Migration[7.0]
  def change
    reversible do |dir|
      change_table :products do |t|
        dir.up   { t.change :price, :string }
        dir.down { t.change :price, :integer }
      end
    end
  end
  def up
    change_table :products do |t|
      t.change :price, :string
    end
  end
  def down
    rename_column :users, :email_address, :email
    remove_column :users, :home_page_url
    change_table :products do |t|
      t.change :price, :integer
    end
  end
end
```

## Associations
An association is a connection between two Active Record models.

```ruby
class Author < ApplicationRecord
  has_many :books, dependent: :destroy
end

class Book < ApplicationRecord
  belongs_to :author
end

@book = @author.books.create(published_at: Time.now) #Create a new book for a particular author
@author.destroy #Deleting an author and all of its books

class CreateAuthors < ActiveRecord::Migration[7.0]
  def change
    create_table :authors do |t|
      t.string :name
      t.timestamps
    end

    create_table :books do |t|
      t.belongs_to :author
      t.datetime :published_at
      t.timestamps
    end
  end
end

create_table :books do |t|
  t.belongs_to :author, index: true, foreign_key: true
  # ...
end

class Physician < ApplicationRecord
  has_many :appointments
  has_many :patients, through: :appointments
end

class Appointment < ApplicationRecord
  belongs_to :physician
  belongs_to :patient
end

class Patient < ApplicationRecord
  has_many :appointments
  has_many :physicians, through: :appointments
end
```

## References
- https://guides.rubyonrails.org/active_record_basics.html
- https://guides.rubyonrails.org/active_record_callbacks.html
- https://guides.rubyonrails.org/active_record_migrations.html
- https://guides.rubyonrails.org/association_basics.html#the-has-many-association