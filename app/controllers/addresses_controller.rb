class AddressesController < ApplicationController

  layout "application"
  before_filter :require_login

  def index
    @addresses = Address.all
  end

 
  def show
    @address = Address.find(params[:id])
  end

  
  def new
    @addressable = find_addressable
  end

  
  def edit
     @addressable = find_addressable
     @address = @addressable.addresses.build(params[:address])
  end

  
  def create
   @addressable = find_addressable
   @address = @addressable.addresses.build(params[:address])
      if @address.save
       redirect_to parent_url(@address)
      else
        render action: "new" 
      end  
  end

 
  def update
    @addressable = find_addressable
      if @addressable.update_attributes(params[:address])
        redirect_to customer_path(@address.customer_id)
      else
        render action: "edit" 
      end
  end

  
  def destroy
    @addressable = find_addressable
    @address = @addressable.addresses.find_by_id(params[:id])
    @address.destroy
    redirect_to request.env['HTTP_REFERER']
  end

  
  private

  def parent_url(address)

    if address.addressable_type == "Customer"
      return customer_path(@addressable)
    end
    if address.addressable_type == "Contact"
      contact = Contact.find_by_id(address.addressable_id)
      customer = Customer.find_by_id(contact.customer_id)
    return  customer_contact_path(customer, contact)

  end
end

  def find_addressable
   params.each do |name, value|
      if name =~ /(.+)_id$/
        case $1
          when "customer"
            return Customer.find_by_id(value)
          when "contact"
            return Contact.find_by_id(value)
          end
        end
      
      nil
    end  
  end

end
