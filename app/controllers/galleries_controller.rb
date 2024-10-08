class GalleriesController < ApplicationController
  before_action :authenticate_user!, only: [:new, :create, :apply]

  def index
    @galleries = Gallery.all
    @user = current_user
  end

  def show
    @gallery = Gallery.find(params[:id])
    @user = current_user
    @application = @gallery.applications.new
  end

  def apply
    @gallery = Gallery.find(params[:id])

    if current_user == @gallery.user
      flash[:alert] = "You can't reserve your own gallery"
      redirect_to gallery_path(@gallery)
    else
      # @application = @gallery.applications.build(application_params.merge(user_id: current_user.id))
      @application = Application.new(application_params)
      @application.gallery_id = @gallery.id
      @application.user_id = current_user.id
      @application.status = "pending"

      if @application.save
        redirect_to user_applications_path(current_user), notice: 'Application was successfully created.'
      else
        render :show
      end
    end
  end

  def new
    @gallery = Gallery.new
    @user = current_user
  end

  def create
    @gallery = current_user.galleries.build(gallery_params)
    @user = current_user

    if @gallery.save
      redirect_to @gallery, notice: 'Gallery was successfully created.'
    else
      render :new, status: :unprocessable_entity
    end
  end

  private

  def gallery_params
    params.require(:gallery).permit(:name, :address, :description, :price, photos: [])
  end

  def application_params
    params.require(:application).permit(:start_date, :end_date, :description, photos: []) # Adjust according to your model
  end
end
