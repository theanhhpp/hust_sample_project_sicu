class CommentsController < ApplicationController
	before_action :set_post

	def create
	    @comment = @post.comments.build(comment_params)
	    @comment.user_id = current_user.id

	    if @comment.save
	    	create_notification @post, @comment
	    	respond_to do |format|
	        format.html { redirect_to root_path }
	        format.js {render inline: "location.reload();" }
	      end
	    else
	      flash[:alert] = "Check the comment form, something went wrong."
	      render root_path
	    end

	end
	def destroy
	    @comment = @post.comments.find(params[:id])

	    if @comment.user_id == current_user.id || @post.user.id == current_user.id
	      @comment.delete
	      respond_to do |format|
	        format.html { redirect_to root_path }
	        format.js {render inline: "location.reload();" }
	      end
	    end
	end

	private

	def create_notification(post, comment)  
	    return if post.user.id == current_user.id 
	    Notification.create(user_id: post.user.id,
	                        notified_by_id: current_user.id,
	                        post_id: post.id,
	                        identifier: comment.id,
	                        notice_type: 'commented on your post')
	end
	def comment_params  
	  params.require(:comment).permit(:content)
	end

	def set_post  
	  @post = Post.find(params[:post_id])
	end  
end
