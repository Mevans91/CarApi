class Api::V1::VehiclesController < ApplicationController
    skip_before_action :authenticate, only: [:index, :show]
    before_action :set_vehicle, only: [:show, :update, :destroy]
    
    #Get 
    def index
        @vehicles = Vehicle.all
        render json: @vehicles
    end

    #Get
    def show
        @vehicle = Vehicle.where(vehicle_id: params[:id])
        render json: { vehicle: @vehicle }
    end

    #Post
    def create
        @vehicle = Vehicle.new(vehicle_params)
        if @vehicle.save
            render json: @vehicle
        else
            render json: @vehicle.errors, status: :unprocessable_entity
        end
    end

    #Patch
    def update
        if @vehicle.update(vehicle_params)
            render json: @vehicle
        else 
            render json: @vehicle.errors, status: :unproccessable_entity
        end
    
    end

    def destroy
        @vehicle.destroy
    end

    #Get our Amazon S3 Keys for image uploads
    def get_upload_credentials
        @accessKey = ENV['S3_ACCESS']
        @secretKey = ENV['S3_SECRET']
        render json: { accessKey: @accessKey, secretKey: @secretKey }
    end


    private
    #Methods we place in private can only be accessed by other methods on our movies controller

    def set_vehicle
        @vehicle = Vehicle.find(params[:id])
    end

    def vehicle_params
        params.require(:vehicle).permit(:make, :model, :year, :mileage, :location, :service_scheduled, :condition, :id)
    end

end
