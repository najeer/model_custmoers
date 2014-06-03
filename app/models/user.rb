class User < ActiveRecord::Base
  has_secure_password
  
  attr_accessible :email, :password, :username,:password_confirmation, :role, :photo, :status
  
  validates_presence_of :username
  validates_presence_of :email 
  validates_uniqueness_of :username, :email , :on => :create
  validates_format_of :email,
                      :with => /^([\w\.%\+\-]+)@([\w\-]+\.)+([\w]{2,})$/i , 
                      :message => 'invalid email'
  validates_presence_of :password,:on => :create
  validates_presence_of :password_confirmation,:on => :create
  validates_presence_of :role
  
  has_attached_file :photo, :styles => { :small => "150x150", :large => "300x300" ,:mini => "50x50"}

  do_not_validate_attachment_file_type :photo
 def self.search(search)  
    if search  
      where("username LIKE ?", "%#{search}%")  
    else  
      scoped  
    end  
  end  

  def activate
     self.status = 1
     self.save
  end

  def deactive
     self.status = 0
     self.save!
  end
end
