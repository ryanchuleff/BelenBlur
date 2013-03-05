class AssetsController < ApplicationController

  def index
    @asset = Asset.first

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @clickers }
    end
  end

  def show
    @asset = Asset.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @asset }
    end
  end

  def new
    @asset = Asset.new

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @asset }
    end
  end

  def edit
    @asset = Asset.find(params[:id])
  end

  def create
    Asset.delete_all
    @asset = Asset.new(params[:asset])

    respond_to do |format|
      if @asset.save
        format.html { redirect_to assets_url, notice: 'Asset was successfully created.' }
        format.json { render json: @asset, status: :created, location: @asset }
      else
        format.html { render action: "new" }
        format.json { render json: @asset.errors, status: :unprocessable_entity }
      end
    end
  end

  def update
    @asset = Asset.find(params[:id])
    @asset.assetable_id = 0
    @asset.save

    redirect_to root_url
  end

  def destroy
    @asset = Asset.find(params[:id])
    @asset.destroy

    respond_to do |format|
      format.html { redirect_to assets_url }
      format.json { head :no_content }
    end
  end
end
