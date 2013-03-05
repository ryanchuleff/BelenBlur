class ClickersController < ApplicationController

  def index
    @asset = Asset.first

    @ip = request.remote_ip 
  end

  # POST /clickers
  # POST /clickers.json
  def create
    @clicker = Clicker.find_or_create_by_address(request.remote_ip)
    @clicker.clicks = @clicker.clicks.nil? ? 0 : (@clicker.clicks+1).to_i

    @asset = Asset.find(params[:asset_id])
    @asset.assetable_id = @asset.assetable_id.nil? ? 0 : (@asset.assetable_id+1).to_i
    @asset.save

    respond_to do |format|
      if @clicker.save
        format.js 
        format.json { render json: @clicker, status: :created, location: @clicker }
      else
        format.html { render action: "new" }
        format.json { render json: @clicker.errors, status: :unprocessable_entity }
      end
    end
  end

  def update
    @clicker = Clicker.find_or_create_by_address(request.remote_ip)

    @asset = Asset.find(params[:asset_id])
    @asset.assetable_id = 0
    @asset.save

    render action: "index"
  end
end
