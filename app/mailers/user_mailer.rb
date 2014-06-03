class UserMailer < ActionMailer::Base
  default from: "noreply@noreplay.com"

  def registration_confirmation(user)
    @user = user    
    mail(:to => user.email, :subject => "Registered")  
  end  
  def change_password_confirmation(user)
    @user = user    
    mail(:to => user.email, :subject => "Password Change Information") 
  end
  def forgot_password_confirmation(user)
    @user = user    
    mail(:to => user.email, :subject => "Forgot Password Information") 
  end
end