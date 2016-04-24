module ApplicationHelper
	def alert_for(flash_type)
	  { success: 'alert-success',
	    error: 'alert-danger',
	    alert: 'alert-warning',
	    notice: 'alert-info'
	  }[flash_type.to_sym] || flash_type.to_s
	end

	def form_image_select(post)
	  return image_tag post.image.url,
	                   id: 'image-preview',
	                   class: 'img-responsive' if post.image.exists?
	  image_tag 'regbackg.jpg', id: 'image-preview', class: 'img-responsive'
	end

	def profile_avatar_select(user)
	  return image_tag user.avatar.url(:medium),
	                   id: 'avatar-preview',
	                   class: 'img-responsive avatar' if user.avatar.exists?
	  image_tag 'default-avatar.jpg', id: 'avatar-preview',
	                                  class: 'img-responsive avatar'
	end

    def profile_avatar_select_md(user)
      return image_tag user.avatar.url(:medium),
                       id: 'avatar-md-preview',
                       class: 'img-responsive avatar-md' if user.avatar.exists?
      image_tag 'default-avatar.jpg', id: 'avatar-md-preview',
                                      class: 'img-responsive avatar-md'
    end

    def profile_avatar_select_sm(user)
      return image_tag user.avatar.url(:medium),
                       id: 'avatar-sm-preview',
                       class: 'img-responsive avatar-sm' if user.avatar.exists?
      image_tag 'default-avatar.jpg', id: 'avatar-sm-preview',
                                      class: 'img-responsive avatar-sm'
    end

    def profile_avatar_select_profiles(user)
      return image_tag user.avatar.url(:medium),
                       id: 'avatar-profile-preview',
                       class: 'img-responsive img-thumbnail avatar-profiles' if user.avatar.exists?
      image_tag 'default-avatar.jpg', id: 'avatar-profile-preview',
                                      class: 'img-responsive img-thumbnail avatar-profiles'
    end

end
