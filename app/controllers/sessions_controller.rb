class SessionsController < ApplicationController
    skip_before_action :login_required, only: %i(new create)
    
    # 省略
    def create
        user = User.find_by(email: params[:session][:email].downcase)
        if user&.authenticate(params[:session][:password])
            session[:user_id] = user.id
            redirect_to user_path(user.id)
        else
            flash.now[:danger] = 'ログインに失敗しました'
            render :new
    end
  end
# 省略
    def destroy
        session.delete(:user_id)
        flash[:notice] = 'Vous avez été déconnecté.'
        redirect_to new_session_path
    end
end