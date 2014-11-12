 class UsersController < ApplicationController
   before_action :authenticate_user!
 
    def show
      @user = User.find(params[:id])
      @lists = @user.lists.paginate(page: params[:page], per_page: 10)
     end 

   def update
     if current_user.update_attributes(user_params)
       flash[:notice] = "User information updated"
       redirect_to edit_user_registration_path(current_user)
     else
       flash[:error] = "Invalid user information"
       redirect_to edit_user_registration_path
     end
   end
 
   private
 
   def user_params
     params.require(:user).permit(:name)
   end
 end