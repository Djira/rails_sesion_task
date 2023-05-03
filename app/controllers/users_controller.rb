class UsersController < ApplicationController
  before_action :set_user, only: %i(show edit update destroy correct_user)
  skip_before_action :login_required, only: %i(new create)
  before_action :correct_user, only: %i(show edit update destroy)

  

  # GET /users or /users.json
  def index
    @users = User.all
  end

  # GET /users/1 or /users/1.json
  def show
  end

  # GET /users/new
  def new
    @user = User.new
  end

  # GET /users/1/edit
  def edit
  end

  # POST /users or /users.json
  
  
  def create
    @user = User.new(user_params)
    if @user.save
      log_in(@user)
      redirect_to tasks_path, notice: 'アカウントを登録しました'
    else
      render :new
    end
  end

  # PATCH/PUT /users/1 or /users/1.json
  def update
    if @user.update(user_params)
      redirect_to @user, notice: 'アカウントを更新しました'
    else
      render :edit
    end
  end

  # DELETE /users/1 or /users/1.json
  def destroy
    @user.destroy
    redirect_to new_session_path
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_user
      @user = User.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def user_params
      params.require(:user).permit(:name, :email, :password, :password_confirmation)
    end
  
    def correct_user
      #@user = User.find(params[:id])
      redirect_to current_user unless current_user?(@user)
    end
end
