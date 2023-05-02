class SessionsController < ApplicationController
    skip_before_action :login_required, only: %i(new create)
    
    # 省略
    def create
        user = User.find_by(email: params[:session][:email].downcase)
        if user && user.authenticate(params[:session][:password])
          log_in(user)
          redirect_to tasks_path, notice: 'ログインしました'
        else
          flash[:danger] = 'Je n ai pas réussi à me connecter'
          render :new
        end
      end
# 省略
    def destroy
        session.delete(:user_id)
        flash[:notice] = 'Vous avez été déconnecté.'
        redirect_to new_session_path
    end
    def new
    end
end
