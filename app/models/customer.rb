class Customer < ActiveRecord::Base
  attr_accessible :name, :phoneno,  :fax,  :legal_name, :website_url, :status
 
  has_many :addresses, :as => :addressable  
  has_many :notes, :as => :notable
  has_many :contacts

   validates_uniqueness_of :name, :message => 'Already Customer exist'
   validates_presence_of :phoneno, :message => 'Invalid phone number' 
   validates_presence_of :fax, :message => 'Invalid phone number' 
   validates_presence_of :legal_name, :message => 'Should not be blank' 
   validates_presence_of :website_url, :message => 'Should not be blank'


   def self.search(search1, search2) 
    if search1.present?
          where('name LIKE ?', "%#{search1}%")
            elsif search2.present?
              where('phoneno LIKE ?', "%#{search2}%") 
                   else  
                         scoped  
             end  
   end
  def has_primary_address?
    addresses.each do |address|
      if address.address_type =="Primary"
        return false
      end
    end
    return true
  end

  def has_primary_contact
    addresses.each do |address|
      if address.address_type =="Primary"
        return false
      end
    end
    return true
  end

  def activate
     self.status = 1
     self.save
  end

  def deactive
     self.status = 0
     self.save
  end

def self.to_csv(options = {})
     customers = Customer.find(:all,:conditions=>['status = 1'])
    CSV.generate(options) do |csv|
    csv << column_names
    all.each do |customer|
      csv << customer.attributes.values_at(*column_names)
    end
  end

    #CSV.generate do |csv|
     #csv << ["Name","Phone No","Fax","Legal Name","Website","Status"]
      #customers.each do |customer|
       # csv << [customer.name,customer.phoneno,customer.fax,customer.legal_name,customer.website_url,customer.status]
      #end
    #end 
  end

 def self.import(file)
   CSV.foreach(file.path, headers: true) do |row|
     customer = find_by_id(row["name"]) || new
     customer.attributes = row.to_hash.slice(*accessible_attributes)
     customer.save!
   end
 end

 # def self.import(file)
 #   CSV.foreach(file.path, headers: true) do |row|
 #   Customer.create! row.to_hash
 #   end
 # end

end