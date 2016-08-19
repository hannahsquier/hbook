module UsersHelper

	def get_cover_photo
		return nil unless User.find(current_page_user_id).profile.cover_photo_id
		Photo.find(User.find(current_page_user_id).profile.cover_photo_id)
	end

	def get_profile_photo
		return nil unless User.find(current_page_user_id).profile.profile_photo_id
		Photo.find(User.find(current_page_user_id).profile.profile_photo_id)
	end

end
