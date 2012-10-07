class DomainsController < ApplicationController
  require "web_page_analyser"

  def index
    @domains = Domain.order("name").page(params[:page]).per(10)
    
    respond_to do |format|
      format.html
      format.json  { render :json => @domains }
    end
  end
  
  def new
    @domain = Domain.new
    @domain.active = true
    respond_to do |format|
      format.html
    end
  end

  def create
    @domain = Domain.new(params[:domain])

    respond_to do |format|
      if @domain.save
        format.html  { redirect_to(@domain,
                                   :notice => 'Domain was successfully created.') }
        format.json  { render :json => @domain,
                              :status => :created, :location => @domain }
      else
        format.html  { render :action => "new" }
        format.json  { render :json => @domain.errors,
                              :status => :unprocessable_entity }
      end
    end
  end

  def show
    @domain = Domain.find(params[:id])
    respond_to do |format|
      format.html
      format.json  { render :json => @domain }
    end
  end

  def edit
    @domain = Domain.find(params[:id])
    respond_to do |format|
      format.html
      format.json  { render :json => @domain }
    end
  end

  def update
    @domain = Domain.find(params[:id])
    respond_to do |format|
      if @domain.update_attributes(params[:domain])
        format.html  { redirect_to(@domain,
                                   :notice => 'Domain was successfully updated.') }
        format.json  { head :no_content }
      else
        format.html  { render :action => "edit" }
        format.json  { render :json => @domain.errors,
                              :status => :unprocessable_entity }
      end
    end
  end

  def destroy
    @domain = Domain.find(params[:id])
    @domain.destroy

    respond_to do |format|
      format.html { redirect_to @domain,
                                :notice => 'Domain was successfully deleted.'}
      format.json { head :no_content }
    end
  end


end
