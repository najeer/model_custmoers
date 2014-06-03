class ContactsController < ApplicationController

  layout "application"
   before_filter :require_login
   before_filter :find_customer

   before_filter :find_contact,:except => [:new, :create]


  def show
  end

 
  def new
    @contact = Contact.new
  end

 
  def edit
  end

  def create
    @contact = @customer.contacts.build(params[:contact])
      if @contact.save!
        redirect_to customer_path(@customer)
      else
        render "new" 
      end
  end

  
  def update
    if @customer.contacts.update_attributes(params[:address])
        redirect_to customer_path(@customer)
    else
      render "edit" 
    end
    
  end

  
  def destroy
    @contact.destroy
    redirect_to customer_path(@customer)
  end

  private

  def find_customer
    @customer = Customer.find(params[:customer_id])
    if not @customer
      raise ActiveRecord::RecordNotFound
    end
  end

  def find_contact
    @contact = @customer.contacts.find(params[:id])
    if not @contact
      raise ActiveRecord::RecordNotFound
    end
  end


end
