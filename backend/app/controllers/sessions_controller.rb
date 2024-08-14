class SessionsController < ApplicationController
    include CurrentUserConcern

    def create
        user=User.find_by(email: params["user"]["email"]).try(:authenticate, params["user"]["password"]) # default method authenticate
        if user
            session[:user_id]=user.id
            render json: {
                status: :created,
                logged_in: true
            }
        else
            render json: {
                status:  401
            }
        end
    end

    def logged_in
        if @current_user
            render json: {
                logged_in: true
            }
        else
            render json: {
                logged_in: false
            }
        end
    end

    def logout
        reset_session
        render json: {
            status: 200,
            logged_out: true
        }
    end
end
