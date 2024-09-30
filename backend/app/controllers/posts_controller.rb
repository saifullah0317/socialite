class PostsController < ApplicationController
    # include CurrentUserConcern
    def create
        @query_params=post_params
        # @query_params['user_id']=@current_user.id
        # puts "current_user: #{@current_user}"
        @query_params['user_id']='5'
        puts "query_params: #{@query_params}"
        begin
            @created_post=Post.create(@query_params)
            render json: {
                status: :created,
                post: @created_post
            }
        rescue => e
            puts "error while creating post: #{e}"
            render json: {
                message: e.message,
                status: 500
            }
        end
    end

    def index
    #     puts "current_user: #{@current_user}"
    #     @posts=Post.where(user_id: @current_user.id)
        @posts=Post.where(user_id: '5')
        puts "posts of current_user: #{@posts}"
        if @posts
            render json: {
                status: :ok,
                posts: @posts
            }
        else
            render json: {
                status: 500
            }
        end
    end

    private
    def post_params
        params.require(:post).permit(:description, images: [])
    end

end