class PhotosController < ApplicationController
    def index
        photos = Photo.all
        render json: photos
    end

    def show
        photo =Photo.find(params[:id])
        render json: photo
    end
    
    def edit
        photo = Photo.find(params[:id])
        render json: photo
    end
    
    def create
        photo = Photo.create(photo_params)
        if photo.valid?
            render json: photo
        else
            render json: photo.errors, status: 422
        end
    end  

    def update
        photo = Photo.find(params[:id])
        photo.update(photo_params)
        if photo.valid?
            render json: photo
        else
            render json: photo.errors, status: 422
        end
    end

    def destroy
        photo = Photo.find(params[:id])
        if photo.destroy
            render json: photo
        else
            render json: photo.errors
        end
    end

private
    def photo_params
        params.require(:photo).permit(:destination_id, :image, :description)
    end
end

