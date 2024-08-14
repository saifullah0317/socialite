class FriendshipsController < ApplicationController

    include CurrentUserConcern

    def create
        @friend = User.find(params[:friend_id])
        @current_user.friends << @friend
        if @current_user.save
        render json: {error: "Friend added!"}
        else
        render json: {error: "Unable to add friend."}
        end
    end

    def destroy
        @friend = User.find(params[:id])
        @current_user.friends.delete(@friend)
        render json: {error: "Friend removed!"}
    end
end