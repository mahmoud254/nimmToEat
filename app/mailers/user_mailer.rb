class UserMailer < ApplicationMailer
    default from: 'nahm.reads@gmail.com'
 
    def welcome_email(user)
      @user = user
      @url  = 'http://www.nimmToEat.com'
      mail(to: @user.email, subject: 'Welcome to My Awesome Site')
    end
    def forgot(user,pass)
      @user = user
      @pass=pass
      mail(to: @user.email, subject: 'Password Reset')
    end
end
