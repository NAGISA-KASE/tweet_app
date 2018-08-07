class UsersController < ApplicationController

  before_action :authenticate_user, {only: [:index, :show, :edit, :update]}
  before_action :forbid_login_user, {only: [:new, :create, :login_form, :login]}
  before_action :ensure_correct_user, {only: [:edit, :update]}

  def index
  	@users = User.all
  end

  def show
  	@user = User.find_by(id: params[:id])
    @user_account = "@" + @user.account_name
  end

  def new
  	@user = User.new
  end

  def create
  	@user = User.new(
      user_params
  	)
    @user.image_name = "default_user.jpeg"

  	if @user.save
      session[:user_id] = @user.id
  		flash[:notice] = "ユーザー登録が完了しました。TweetAppへようこそ！"
  		redirect_to("/users/#{@user.id}")
  	else
  		render("users/new")
  	end
  end

  def edit
  	@user = User.find_by(id: params[:id])
  end

  def update
  	@user = User.find_by(id: params[:id])
  	@user.name = params[:user][:name]
    @user.introduction = params[:user][:introduction]
    @user.avatar = params[:user][:avatar]

  	if params[:user][:avatar]
	   @user.image_name = "#{@user.id}.jpg"
  	 image = params[:user][:avatar]
  	 File.binwrite("public/user_images/#{@user.image_name}", image.read)
  	end

  	if @user.save
  		flash[:notice] = "ユーザー情報を編集しました"
  		redirect_to("/users/#{@user.id}")
  	else
  		render("users/edit")
  	end
  end

  def login_form
  end

  def login
    @user = User.find_by(email: params[:email])

    if @user && @user.authenticate(params[:password])
      session[:user_id] = @user.id
      flash[:notice] = "ようこそ、 #{@user.name}さん" #ログインしました
      redirect_to("/posts/index")
    else
      @error_message = "メールアドレスまたはパスワードが間違っています"
      @email = params[:email]
      @password = params[:password]
      render("users/login_form")
    end
  end

  def logout
    session[:user_id] = nil
    flash[:notice] ="ログアウトしました"
    redirect_to("/login")
  end

  def likes
    @user = User.find_by(id: params[:id])
    @likes = Like.where(user_id: @user.id)
  end

  def ensure_correct_user
    if @current_user.id != params[:id].to_i
      flash[:notice] = "権限がありません"
      redirect_to("/posts/index")
    end    
  end

  private
  def user_params
    params.require(:user).permit(:name, :account_name, :email, :password, :image_name, :avatar, :introduction)  
  end
end
