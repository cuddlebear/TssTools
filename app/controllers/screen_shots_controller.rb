class ScreenShotsController < ApplicationController
  # GET /screen_shots
  # GET /screen_shots.json
  def index
    @screen_shots = ScreenShot.all

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @screen_shots }
    end
  end

  # GET /screen_shots/1
  # GET /screen_shots/1.json
  def show
    @screen_shot = ScreenShot.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @screen_shot }
    end
  end

  # GET /screen_shots/new
  # GET /screen_shots/new.json
  def new
    @screen_shot = ScreenShot.new

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @screen_shot }
    end
  end

  # GET /screen_shots/1/edit
  def edit
    @screen_shot = ScreenShot.find(params[:id])
  end

  # POST /screen_shots
  # POST /screen_shots.json
  def create
    @screen_shot = ScreenShot.new(params[:screen_shot])

    respond_to do |format|
      if @screen_shot.save
        format.html { redirect_to @screen_shot, notice: 'Screen shot was successfully created.' }
        format.json { render json: @screen_shot, status: :created, location: @screen_shot }
      else
        format.html { render action: "new" }
        format.json { render json: @screen_shot.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /screen_shots/1
  # PUT /screen_shots/1.json
  def update
    @screen_shot = ScreenShot.find(params[:id])

    respond_to do |format|
      if @screen_shot.update_attributes(params[:screen_shot])
        format.html { redirect_to @screen_shot, notice: 'Screen shot was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @screen_shot.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /screen_shots/1
  # DELETE /screen_shots/1.json
  def destroy
    @screen_shot = ScreenShot.find(params[:id])
    @screen_shot.destroy

    respond_to do |format|
      format.html { redirect_to screen_shots_url }
      format.json { head :no_content }
    end
  end
end
