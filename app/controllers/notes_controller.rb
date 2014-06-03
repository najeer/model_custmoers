class NotesController < ApplicationController
  layout "application"
  before_filter :require_login
  
  def index
    @notes = Note.all
  end

  def show
    @note = Note.find(params[:id])
  end

 
  def new
    @notable = find_noteable
  end
  
  def create
     @notable = find_noteable
     @note = @notable.notes.build(params[:note])
      if @note.save
       redirect_to customer_path(@notable)
      else
        render action: "new" 
      end  
  end

 
  def destroy
  
    @notable = find_noteable
    @note = @notable.notes.find_by_id(params[:id])
    if @note
    @note.destroy
  end
    redirect_to request.env['HTTP_REFERER']
  end

  private 
  
  def find_noteable   
    params.each do |name, value|
      if name =~ /(.+)_id$/
        case $1
        when "customer"
          return Customer.find_by_id(value)
        end
      end
    end
    nil
  end
end