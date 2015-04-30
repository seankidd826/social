class PhotosController < ApplicationController

  before_action :authenticate_user!, :except => [:index]

  def index
    @photos = Photo.order("id DESC")
  end

  def new
    @photo = Photo.new
  end

  def create
    @photo = Photo.new( photo_params )
    @photo.user = current_user

    if @photo.save
      redirect_to root_url
    else
      render :action => :new
    end
  end

  def edit
    @photo = current_user.photos.find( params[:id] )
  end

  def update
    @photo = current_user.photos.find( params[:id] )

    if params[:destroy_pic]
      @photo.image = nil
    end

    if @photo.update( photo_params )
      redirect_to root_url
    else
      render :action => :edit
    end
  end

  def destroy
    @photo = current_user.photos.find( params[:id] )
    @photo.destroy

    redirect_to root_url
  end

  protected

  def photo_params
    params.require(:photo).permit(:image, :content)
  end

end
