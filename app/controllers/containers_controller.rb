class ContainersController < ApplicationController
  @@page_size = 100

  # GET /containers
  # GET /containers.json
  def index
    @domain = Domain.find(params[:domain_id])
    @containers = Container.includes(:domain).includes(:content_type_property).
        where(domain_id: @domain.id).rank("row_order").page(params[:page]).per(@@page_size)

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @containers }
    end
  end

  # GET /containers/1
  # GET /containers/1.json
  def show
    @container = Container.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @container }
    end
  end

  # GET /containers/new
  # GET /containers/new.json
  def new
    @container = Container.new
    @container.domain_id = params[:domain_id]

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @container }
    end
  end

  # GET /containers/1/edit
  def edit
    @container = Container.find(params[:id])
  end

  # POST /containers
  # POST /containers.json
  def create
    @container = Container.new(params[:container])

    respond_to do |format|
      if @container.save
        format.html { redirect_to containers_path(domain_id: @container.domain_id), notice: 'Container was successfully created.' }
        format.json { render json: @container, status: :created, location: @container }
      else
        format.html { render action: "new" }
        format.json { render json: @container.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /containers/1
  # PUT /containers/1.json
  def update
    @container = Container.find(params[:id])

    respond_to do |format|
      if @container.update_attributes(params[:container])
        format.html { redirect_to containers_path(domain_id: @container.domain_id), notice: 'Container was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @container.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /containers/1
  # DELETE /containers/1.json
  def destroy
    @container = Container.find(params[:id])
    domain_id = @container.domain_id
    @container.destroy

    respond_to do |format|
      format.html { redirect_to containers_path(domain_id: domain_id) }
      format.json { head :no_content }
    end
  end


  def sort
    @container = Container.find(params[:id])
    offset = Container.rank(:row_order).where("domain_id < ?",@container.domain_id).count()
    @container.update_attribute :row_order_position,  offset + params[:row_order_position].to_i
    # this action will be called via ajax
    render nothing: true
  end

end
