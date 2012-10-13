require "web_page_analyser"

class PagesController < ApplicationController
  @@page_size = 25

  def index
    @pages = Page.includes(:domain).includes(:area).where(domain_id: params[:domain_id]).order("path").page(params[:page]).per(@@page_size)
    @domain = Domain.find(params[:domain_id])

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @pages }
    end
  end

  def show
    @page = Page.find(params[:id])
    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @page }
    end
  end

  def new
    @page = Page.new
    @page.domain_id = params[:domain_id]
    @page.active = true;

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @page }
    end
  end

  def edit
    @page = Page.find(params[:id])
  end

  def create
    @page = Page.new(params[:page])

    respond_to do |format|
      if @page.save
        #format.html { redirect_to @page, notice: 'Page was successfully created.' }
        WebPageAnalyser.initialize_page(@page)
        format.html { redirect_to pages_url(domain_id:@page.domain_id, page:get_paging_position(@page)), notice: 'Page was successfully created.' }
        #format.html { redirect_to domain_path(@page.domain_id), notice: 'Page was successfully created.' }
        format.json { render json: @page, status: :created, location: @page }
      else
        format.html { render action: "new" }
        format.json { render json: @page.errors, status: :unprocessable_entity }
      end
    end
  end

  def update
    @page = Page.find(params[:id])

    respond_to do |format|
      if @page.update_attributes(params[:page])
        WebPageAnalyser.initialize_page(@page)
        format.html { redirect_to pages_url(domain_id:@page.domain_id, page:get_paging_position(@page)), notice: 'Page was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @page.errors, status: :unprocessable_entity }
      end
    end
  end

  def destroy
    @page = Page.find(params[:id])
    domain_id = @page.domain_id
    position = get_paging_position(@page)
    @page.destroy

    respond_to do |format|
      format.html { redirect_to pages_url(domain_id:@page.domain_id, page:position), notice: 'Page was successfully deleted.' }
      #format.html { redirect_to domain_url(domain_id), notice: 'Page was successfully deleted.' }
      format.json { head :no_content }
    end
  end

  def get_paging_position(page)
    position = 1 + Page.where(domain_id: page.domain_id ).order("path").count(conditions: ["path < ?", page.path]) / @@page_size
  end
end

