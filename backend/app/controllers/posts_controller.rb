class PostsController < ApplicationController
    def create
        Rails.logger.debug("Incoming params: #{params.inspect}")
        # post=Post.create!(description: params["description"], image: params["image"]);
        post=Post.new(post_params)
        if post.save
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

    def show
        @post=Post.find_by(id: params[:id])
        if @post
            render json: {
                status: :ok,
                description: @post.description,
                image: url_for(@post.image),
                video: url_for(@post.video)
                # image: @post.image.attached? ? url_for(@post.image) : nil,
                # video: @post.video.attached? ? url_for(@post.video) : nil
            }
        else
            render json: {
                status: 500
            }
        end
    end

    private
    def post_params
        # params.require(:post).permit(:description, :image, :video, :user_id)
        params.permit(:description, :image, :video, :user_id)
    end

end