class UrlsController < ApplicationController
  def index
    @urls = Url.all

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @urls }
    end
  end

  def show
    @url = Url.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @url }
    end
  end

  def new
    @url = Url.new
    @url.domain_id = params[:domain_id]

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @url }
    end
  end

  def edit
    @url = Url.find(params[:id])
  end

  def create
    @url = Url.new(params[:url])

    respond_to do |format|
      if @url.save
        #format.html { redirect_to @url, notice: 'Url was successfully created.' }
        format.html { redirect_to domain_path(@url.domain_id), notice: 'Url was successfully created.' }
        format.json { render json: @url, status: :created, location: @url }
      else
        format.html { render action: "new" }
        format.json { render json: @url.errors, status: :unprocessable_entity }
      end
    end
  end

  def update
    @url = Url.find(params[:id])

    respond_to do |format|
      if @url.update_attributes(params[:url])
        #format.html { redirect_to @url, notice: 'Url was successfully updated.' }
        format.html { redirect_to domain_url(@url.domain_id), notice: 'Url was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @url.errors, status: :unprocessable_entity }
      end
    end
  end

  def destroy
    @url = Url.find(params[:id])
    @url.destroy

    respond_to do |format|
      format.html { redirect_to urls_url }
      format.json { head :no_content }
    end
  end

end
