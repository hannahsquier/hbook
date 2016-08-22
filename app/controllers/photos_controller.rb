class PhotosController < ApplicationController
  before_action :require_login
  
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
        redirect_to user_photos_path(params[:user_id]), sorry: 'Photo was not uploaded.'
      end
    
  end

  def show
    @photo = Photo.find(params[:id])

  end

  def destroy

    @photo = Photo.find(params[:id])
    user_id = @photo.user_id
    
    if Profile.find_by_user_id(user_id).profile_photo.id == @photo.id ||
         Profile.find_by_user_id(user_id).cover_photo.id == @photo.id
        @photo.update(user_id: nil)

        flash[:success] = 'Photo will no longer show up in your photos, but it 
        is still being used as your cover or profile photo. To fully delete, 
        change your cover/profile photo.'

        redirect_to user_photos_path(user_id)

    else
      if @photo.destroy
        redirect_to user_photos_path(user_id), success: 'Photo was deleted.'
      
      else
        errors = @photo.errors.full_messages.join(", ")
        flash.now[:error] = "Photo was not deleted. #{errors}"
        render :index
      end
    end
  end

	private

	def photo_params
    params.require(:photo).permit(:user_id, :file)
  end
end
