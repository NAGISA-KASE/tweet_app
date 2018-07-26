class ApplicationController < ActionController::Base
	before_action :set_current_user

	# ログイン中のユーザー
	def set_current_user
		@current_user = User.find_by(id: session[:user_id])
	end

	# ログインしていない場合のアクセス制限
	def authenticate_user
		if @current_user == nil
			flash[:notice] = "ログインしてください"
			redirect_to("/login")
		end
	end

	# ログインしている場合のアクセス制限
	def forbid_login_user
		if @current_user
			flash[:notice] ="すでにログインしています"
			redirect_to("/posts/index")
		end
	end

end
