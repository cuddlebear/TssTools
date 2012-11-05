class ChecksController < ApplicationController
  require "web_page_analyser"
  @@page_size = 25

  # GET /checks
  # GET /checks.json
  def index
    @domain = Domain.find(params[:domain_id])
    @checks = Check.joins(:page).where(pages: {domain_id: @domain.id}).where("result_code is null").page(params[:page]).per(@@page_size)

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @checks }
    end
  end

  # GET /checks/1
  # GET /checks/1.json
  def show
    WebPageAnalyser.check_page(params[:id])
    @check = Check.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @check }
    end
  end

  # GET /checks/new
  # GET /checks/new.json
  def new
    @check = Check.new

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @check }
    end
  end

  # GET /checks/1/edit
  def edit
    @check = Check.find(params[:id])
  end

  # POST /checks
  # POST /checks.json
  def create
    @check = Check.new(params[:check])

    respond_to do |format|
      if @check.save
        format.html { redirect_to @check, notice: 'Check was successfully created.' }
        format.json { render json: @check, status: :created, location: @check }
      else
        format.html { render action: "new" }
        format.json { render json: @check.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /checks/1
  # PUT /checks/1.json
  def update
    @check = Check.find(params[:id])

    respond_to do |format|
      if @check.update_attributes(params[:check])
        format.html { redirect_to @check, notice: 'Check was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @check.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /checks/1
  # DELETE /checks/1.json
  def destroy
    @check = Check.find(params[:id])
    @check.destroy

    respond_to do |format|
      format.html { redirect_to checks_url }
      format.json { head :no_content }
    end
  end

  def get_paging_position(check)
    position = 1 + Page.where(domain_id: check.domain_id ).order("path").count(conditions: ["path < ?", check.path]) / @@page_size
  end
end
