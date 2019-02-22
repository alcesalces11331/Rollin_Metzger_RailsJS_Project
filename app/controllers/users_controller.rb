class UsersController < ApplicationController
    before_action :logged_in?

    def new
        @user = User.new
    end

    def create
        @user = User.new(user_params)
        @user.save
       # byebug
        if @user
            session[:user_id] = @user.id
            redirect_to user_path(@user)
        else
            render :new
        end
    end

    def show
        if logged_in?
            @user = User.find_by(id: params[:id])
            @quests = Quest.find_by(user_id: @user.id)
            # for future purposes, this will be placed in the model and will allow use of a dropdown menu to select the quests' events you want to look at
            @quest = @quests[0]
        else
            redirect_to root_url
        end
    end

    private

    def user_params
        params.require(:user).permit(:name, :email, :password)
    end
end
