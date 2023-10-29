class PostsController < ApplicationController
    before_action :set_post, only: [:show, :update, :destroy]

    def index
        @posts = Post.all
       
        json_response(@posts)
    end

    def create
        @post = Post.create!(post_params)

        json_response(@post, :created)
    end

    def show
        json_response(@post)
    end

    def update
        if @post.update(post_params)
            json_response(@post)
        else
            error_response
        end
    end

    def destroy
        @post.destroy
        head :no_content
    end

    private

    def post_params
        params.permit(:title, :body)
    end

    def set_post
        @post = Post.find(params[:id])
        json_response(message: 'Could not find Post with id = ' + params[:id], status: :error) if @post.nil?
    end

    def error_response(status = :error)
        json_response(message: :error, status: :error)
    end
end
