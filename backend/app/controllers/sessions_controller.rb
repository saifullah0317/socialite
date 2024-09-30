class SessionsController < ApplicationController
    # include CurrentUserConcern

    def create
        begin
            
        reset_session
        @user=User.find_by(email: params["user"]["email"]).try(:authenticate, params["user"]["password"])
        puts "user: #{@user}"
        session[:user_id]=@user.id
        puts "session[:user_id] in create sesssion methods: #{session[:user_id]}"
        render json: {
            status: :created,
            logged_in: true
        }

        rescue => e
            render json: {error: e.message}, status: :bad_request
        end
        # reset_session
        # user=User.find_by(email: params["user"]["email"]).try(:authenticate, params["user"]["password"])
        # if user
        #     session[:user_id]=user.id
        #     puts "session[:user_id] in create sesssion methods: #{session[:user_id]}"
        #     render json: {
        #         status: :created,
        #         logged_in: true
        #     }
        # else
        #     render json: {
        #         status:  500
        #     }
        # end
    end

    def logged_in
        if session[:user_id]
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
