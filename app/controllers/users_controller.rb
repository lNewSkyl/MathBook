class UsersController < ApplicationController
	def index
    	@users = User.paginate(page: params[:page], per_page:15)
    end


	def ban
		if current_user.email == "atom-1121@mail.ru"
			@user = User.find(params[:id])
			if @user.access_locked?
				@user.unlock_access!
			else
				@user.lock_access!
			end
			redirect_to request.referrer, notice: "User access locked: #{ @user.access_locked?}"
		else
		    flash[:alert] = "Such a hucker!! But that will not fly :("
		    redirect_to request.referrer
		end	
	end


	def show
	  @user = User.find(params[:id])
	  @articles = @user.articles.paginate(page: params[:page], per_page:5)
	end


	def destroy
		User.find(params[:id]).destroy
	    flash[:success] = "User deleted"
	    redirect_to users_path
	end

	def current_user_params
		params.require(:user).permit(:avatar)
	end

end