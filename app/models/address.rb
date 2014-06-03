class Address < ActiveRecord::Base
  attr_accessible :address_type, :street1, :street2, :city, :state, :country, :zip, :addressable_id, :addressable_type
  
  belongs_to :addressable, :polymorphic => true
  
  
  validates_presence_of :street1, :message => 'Should not be blank'
  validates_presence_of :street2, :message => 'Should not be blank'
  validates_presence_of :city, :message => 'Should not be blank'
  validates_presence_of :state, :message => 'Should not be blank'
  validates_presence_of :country, :message => 'Should not be blank'
  validates_numericality_of :zip, :message => 'Invalid zip code'

end
