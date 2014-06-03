class Note < ActiveRecord::Base
  attr_accessible :customer_id, :category, :description, :notable_id, :notable_type

  belongs_to :notable, :polymorphic => true

  validates_presence_of :category
  validates_presence_of :description

  CATEGORIES = ["call","Demo","email","fax"] 
end
