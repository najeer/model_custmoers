class CustomersController < ApplicationController
 require 'customer_drawer'
 before_filter :require_login
 before_filter :find_customer ,:except=>[:index,:new,:create,:inactive]
 
  def index
  @customers = Customer.where(:status => 1)
   @customers = @customers.search(params[:search1], params[:search2]).order("name").page(params[:page]).per(2)

   respond_to do |format|
      format.html
      format.csv { 
        render text: @customers.to_csv
         }

         format.pdf do
          
          #pdf.text customer.phoneno
          #pdf.text customer.fax
          #pdf.text customer.legal_name
          #pdf.text customer.website_url
          #pdf.text customer.status         
          send_data CustomerDrawer.draw(@customers), :filename => 'customer.pdf', :type => 'application/pdf', :disposition => 'inline'
    end
      
    end  
  end

  def show
  end

  def new
    @customer = Customer.new
  end

  def edit
    @customer = Customer.find(params[:id])
  end

  def create
    @customer = Customer.new(params[:customer])
      if @customer.save
        redirect_to customers_path
      else
        render action: "new"
      end
  end

  def update
      if @customer.update_attributes(params[:customer])
       redirect_to customers_path
      else
       render action: "edit" 
      end
  end

  def destroy
    @customer.destroy
    redirect_to customers_path 
  end


  def activate
    @customer.activate
    redirect_to customers_path
  end
  

  def deactive
    @customer.deactive
    redirect_to customers_path
  end


def inactive
   @customers = Customer.where(:status => 0)
   @customers = @customers.order("name").page(params[:page]).per(2)
end

private

  def find_customer
    @customer = Customer.find(params[:id])
    if not @customer
      raise  ActiveRecord::RecordNotFound
    end
  end

end