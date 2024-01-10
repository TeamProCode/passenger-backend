class DestinationsController < ApplicationController
    def create
        destination = Destination.create(destination_params)
        if destination.valid?
        render json: destination
        else
            render json: destination.errors, status: 422
        end
    end
    
    def index
        destinations = Destination.all
        render json: destinations
    end

    def show
        destination = Destination.find(params[:id])
        render json: destination
    end

    def edit
        destination = Destination.find(params[:id])
        render json: destination
    end

    def update
        destination = Destination.find(params[:id])
        destination.update(destination_params)
        if destination.valid?
            render json: destination
        else
            render json: destination.errors, status: 422
        end
    end

    def destroy
        destination = Destination.find(params[:id])
        if destination.destroy
            render json: destination
        else
            render json: destination.errors
        end
    end

    private
    def destination_params
        params.require(:destination).permit(:location, :climate, :local_language, :user_id, :image, :description)
    end
end
