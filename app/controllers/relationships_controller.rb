class RelationshipsController < ApplicationController
    
  def create
    user = User.find(params[:relationship][:followed_id])
    if current_user.follow(user)
      create_notification user
      redirect_to :back
    end
  end

  def destroy
    user = Relationship.find(params[:id]).followed
    current_user.unfollow(user)
    redirect_to :back
  end
  private

  def create_notification (user) 
      #return if user.id == current_user.id 
      Notification.create(user_id: user.id,
                          notified_by_id: current_user.id,
                          post_id: user.id,
                          identifier: user.id,
                          notice_type: 'follow')
  end
end
