class PhotosController < ApplicationController
	def new
		@photo = Photo.new
	end

	def index
	
		@photos = Photo.all
	end

  def create    
    @photo = Photo.new(photo_params)
   
      if @photo.save
         redirect_to user_photos_path(params[:user_id]), success: 'Photo was uploaded.'
    
      else
      	errors = @photo.errors.full_messages.join(", ")
      	flash[:error] = "Could not upload photo #{errors}"
      	redirect_to user_posts_path(params[:user_id])
        redirect_to user_photos_path(params[:user_id]), sorry: 'Photo was not uploaded.'
      end
    
  end

	private

	def photo_params
    params.require(:photo).permit(:file)
  end
end
