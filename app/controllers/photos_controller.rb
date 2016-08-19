class PhotosController < ApplicationController
	def new
		@photo = Photo.new
	end

	def index
	
		@photos = Photo.where(user_id: params[:user_id])
	end

  def create    
  		@photo = current_user.photos.build(photo_params)

      if @photo.save
         redirect_to user_photos_path(params[:user_id]), success: 'Photo was uploaded.'
    
      else
      	errors = @photo.errors.full_messages.join(", ")
      	flash[:error] = "Could not upload photo #{errors}"
        redirect_to user_photos_path(params[:user_id]), sorry: 'Photo was not uploaded.'
      end
    
  end

	private

	def photo_params
    params.require(:photo).permit(:user_id, :file)
  end
end
