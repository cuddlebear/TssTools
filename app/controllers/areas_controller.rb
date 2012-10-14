class AreasController < ApplicationController
  @@page_size = 25

  # GET /areas
  # GET /areas.json
  def index
    @domain = Domain.find(params[:domain_id])
    @areas = Area.includes(:domain).includes(:filter_type_property).includes(:interval_property).
              where(domain_id: @domain.id).rank("row_order").page(params[:page]).per(@@page_size)

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @areas }
    end
  end

  # GET /areas/1
  # GET /areas/1.json
  def show
    @area = Area.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @area }
    end
  end

  # GET /areas/new
  # GET /areas/new.json
  def new
    @area = Area.new
    @area.domain_id = params[:domain_id]

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @area }
    end
  end

  # GET /areas/1/edit
  def edit
    @area = Area.find(params[:id])
  end

  # POST /areas
  # POST /areas.json
  def create
    @area = Area.new(params[:area])

    respond_to do |format|
      if @area.save
        format.html { redirect_to  areas_url(domain_id: @area.domain_id), notice: 'Area was successfully created.' }
        format.json { render json: @area, status: :created, location: @area }
      else
        format.html { render action: "new" }
        format.json { render json: @area.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /areas/1
  # PUT /areas/1.json
  def update
    @area = Area.find(params[:id])

    respond_to do |format|
      if @area.update_attributes(params[:area])
        format.html { redirect_to areas_url(domain_id: @area.domain_id), notice: 'Area was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @area.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /areas/1
  # DELETE /areas/1.json
  def destroy
    @area = Area.find(params[:id])
    domain_id = @area.domain_id
    @area.destroy

    respond_to do |format|
      format.html { redirect_to areas_url domain_id: domain_id, notice: 'Area was successfully deleted.' }
      format.json { head :no_content }
    end
  end

  def sort
    @area = Area.find(params[:id])
    offset = Area.rank(:row_order).where("domain_id < ?",@area.domain_id).count()
    @area.update_attribute :row_order_position,  offset + params[:row_order_position].to_i
    # this action will be called via ajax
    render nothing: true
  end

  def get_paging_position(area)
    position = 1 + Area.where(domain_id: area.domain_id ).order("sort_order").count(conditions: ["sort_order < ?", area.sort_order]) / @@page_size
  end
end
