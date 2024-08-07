class PostsController < ApplicationController
    def create
        post=Post.create!(description: params["description"], image: params["image"]);
        if post
            render json: {
                status: :created,
                post: post
            }
        else
            render json: {
                status: 500
            }
        end
    end
    # def post_params
    #     params.require(:post).permit(:description, :image)
    # end
end