class DomainController < ApplicationController
  def index
    @domains = Domain.all
    
    respond_to do |format|
      format.html
    end
  end
  
  def new
    @domain = Domain.new
    respond_to do |format|
      format.html
    end
  end

  def edit
  end
  
  def show
    @domain = Domain.find(params[:id])
  end
end
