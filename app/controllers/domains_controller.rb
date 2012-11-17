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
    id = params[:id]
    unless id.nil?
      if id.match(/^[0-9a-f]{8}-[0-9a-f]{4}-[0-9a-f]{4}-[0-9a-f]{4}-[0-9a-f]{12}$/)
        @domain = Domain.find_all_by_uuid(id).first
      else
        @domain = Domain.find(id)
      end
    end

    pages_new          = Page.where(:domain_id => @domain.id, :status => 0).count
    pages_unknown      = Page.where(:domain_id => @domain.id, :status => 1).count
    pages_maintainance = Page.where(:domain_id => @domain.id, :status => 2).count
    pages_warning      = Page.where(:domain_id => @domain.id, :status => 3).count
    pages_critical     = Page.where(:domain_id => @domain.id, :status => 4).count
    pages_ok           = Page.where(:domain_id => @domain.id, :status => 5).count

    data_table = GoogleVisualr::DataTable.new
    data_table.new_column('string', 'Pages')
    data_table.new_column('number', 'Count')
    data_table.add_rows(5)
    data_table.set_cell(0, 0, 'New'     )
    data_table.set_cell(0, 1, pages_new )
    data_table.set_cell(1, 0, 'Unknown'      )
    data_table.set_cell(1, 1, pages_unknown  )
    data_table.set_cell(2, 0, 'Warning' )
    data_table.set_cell(2, 1, pages_warning  )
    data_table.set_cell(3, 0, 'Critical'    )
    data_table.set_cell(3, 1, pages_critical  )
    data_table.set_cell(4, 0, 'OK'    )
    data_table.set_cell(4, 1, pages_ok  )

    opts   = { :width => 400, :height => 300, :title => 'Status of pages', :is3D => true }
    @chart = GoogleVisualr::Interactive::PieChart.new(data_table, opts)
    @table = GoogleVisualr::Interactive::Table.new(data_table)


    respond_to do |format|
      format.html
      format.json  { render :json => @domain }
    end
  end

  def edit
    id = params[:id]
    unless id.nil?
      if id.match(/^[0-9a-f]{8}-[0-9a-f]{4}-[0-9a-f]{4}-[0-9a-f]{4}-[0-9a-f]{12}$/)
        @domain = Domain.find_all_by_uuid(id).first
      else
        @domain = Domain.find(id)
      end
    end

    respond_to do |format|
      format.html
      format.json  { render :json => @domain }
    end
  end

  def update
    id = params[:id]
    unless id.nil?
      if id.match(/^[0-9a-f]{8}-[0-9a-f]{4}-[0-9a-f]{4}-[0-9a-f]{4}-[0-9a-f]{12}$/)
        @domain = Domain.find_all_by_uuid(id).first
      else
        @domain = Domain.find(id)
      end
    end

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

  def disable
    @domain = Domain.find(params[:id])
    if @domain.active?
      @domain.active = false
      @domain.save
      logger.debug "Debug: Domain #{@domain.domain} disabled "
    end

    respond_to do |format|
      format.html { redirect_to domains_path,
                                :notice => 'Domain was ' + @domain.name + 'successfully disabled.'}
      format.json { head :no_content }
    end
  end

  def enable
    @domain = Domain.find(params[:id])
    unless @domain.active?
      @domain.active = true
      @domain.save
      logger.debug "Debug: Domain #{@domain.domain} enabled "
    end

    respond_to do |format|
      format.html { redirect_to domains_path,
                                :notice => 'Domain was ' + @domain.name + ' successfully enabled.'}
      format.json { head :no_content }
    end
  end

  def statistic
    id = params[:id]
    unless id.nil?
      if id.match(/^[0-9a-f]{8}-[0-9a-f]{4}-[0-9a-f]{4}-[0-9a-f]{4}-[0-9a-f]{12}$/)
        @domain = Domain.find_all_by_uuid(id).first
      else
        @domain = Domain.find(id)
      end
    end

    respond_to do |format|
      format.html
      format.json  { render :json => @domain }
    end
  end

end
