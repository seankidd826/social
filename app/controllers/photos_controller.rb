class PhotosController < ApplicationController

  def index
    @photos = Photo.all
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
    @photo = Photo.find( params[:id] )
  end

  def update
    @photo = Photo.find(params[:id])
    if @photo.update( photo_params )

      if params[:destroy_pic]
        @photo.image = nil
        @photo.save
      end

      redirect_to root_url
    else
      render :action => :edit
    end
  end

  def destroy
    @photo = Photo.find(params[:id])
    @photo.destroy

    redirect_to root_url
  end

  protected

  def photo_params
    params.require(:photo).permit(:image, :content)
  end

end
