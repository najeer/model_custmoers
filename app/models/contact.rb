class Contact < ActiveRecord::Base
  attr_accessible :email, :facebook_url, :linkedn_url, :mobile, :name, :phone_no, :twitter_url, :address_type, :street1, :street2, :city, :state, :country, :zip, :addressable_id, :addressable_type
  has_many :addresses, :as => :addressable  

  belongs_to :customer
  
  validates_presence_of :name,:message => 'Should not be blank'
  validates_presence_of :email, :message => 'Should not be blank'
  validates_format_of :email,
                      :with => /^([\w\.%\+\-]+)@([\w\-]+\.)+([\w]{2,})$/i , 
                      :message => 'invalid email'
  validates_numericality_of :phone_no, :message => 'Invalid phone number' 
  validates_numericality_of :mobile, :message => 'Invalid mobile number'
  validates_presence_of :street1, :message => 'Should not be blank' 
  validates_presence_of :street2, :message => 'Should not be blank'
  validates_presence_of :city, :message => 'Should not be blank' 
  validates_presence_of :state, :message => 'Should not be blank' 
  validates_presence_of :country, :message => 'Should not be blank'
  validates_numericality_of :zip, :message => 'Invalid zip code' 
 
 end