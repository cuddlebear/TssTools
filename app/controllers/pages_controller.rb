require "web_page_analyser"

class PagesController < ApplicationController
  @page_size = 25

  def index
    path_id = params[:path_id]
    @path = nil
    @domain = nil
    if path_id.nil?
        domain_id = params[:domain_id]
        unless domain_id.nil?
          if domain_id.match(/^[0-9a-f]{8}-[0-9a-f]{4}-[0-9a-f]{4}-[0-9a-f]{4}-[0-9a-f]{12}$/)
            @domain = Domain.find_all_by_uuid(domain_id).first
          else
            @domain = Domain.find(domain_id)
          end
        end
        @path = Path.where(level: 0,domain_id: @domain.id).first
    else
      if path_id.match(/^[0-9a-f]{8}-[0-9a-f]{4}-[0-9a-f]{4}-[0-9a-f]{4}-[0-9a-f]{12}$/)
        @path = Path.find_all_by_uuid(path_id).first
        @domain = @path.domain
      end
    end

    @parent_path = Path.where(id: @path.path_id).first
    @paths = Path.where(path_id: @path.id).order(:value)
    @pages = Page.includes(:domain).includes(:area).where(domain_id: @domain.id, path_id: @path.id).order("file_name").page(params[:page]).per(@page_size)


    data_table = GoogleVisualr::DataTable.new
    data_table.new_column('string', 'Directory'   )
    data_table.new_column('string', 'Parent directory')
    data_table.new_column('string', 'ToolTip')
    t = []

    @paths.each do |p|
      f = p.value.rpartition("/")[2]
      f = "/" if f.empty?
      parent_path_value = p.value.rpartition("/")[0]
      parent_path_value = "/" if parent_path_value.empty?
      x = view_context.link_to f, pages_path(path_id: p.uuid)
      t << [{v: p.value, f: x }, parent_path_value, '']
    end

    akt_path = @path
    a = 0
    max_lines = 3
    while akt_path && a < max_lines
      a = a+1

      #left box
      left_path = Path.where("path_id = ? and value < ?", akt_path.path_id, akt_path.value).order(:value).last
      t << get_leaf(left_path,false,a==max_lines) if left_path && a < max_lines

      #actual box
      t << get_leaf(akt_path,a==1,a==max_lines)

      #right box
      right_path = Path.where("path_id = ? and value > ?", akt_path.path_id, akt_path.value).order(:value).first
      t << get_leaf(right_path,false,a==max_lines) if right_path && a < max_lines

      akt_path = Path.where(id: akt_path.path_id).first
    end

    data_table.add_rows( t )

    opts   = { :allowHtml => true }
    @chart = GoogleVisualr::Interactive::OrgChart.new(data_table, opts)

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @pages }
    end
  end

  def get_leaf(path, selected=false, last=false )
    f = path.value.rpartition("/")[2]
    f = "/" if f.empty?
    f = "<span style=\"color: red; font-size: 2em;\">#{f}</span>" if selected
    parent_path_value = path.value.rpartition("/")[0]
    parent_path_value = "/" if parent_path_value.empty?
    parent_path_value = "" if last
    link = view_context.link_to f.html_safe, pages_path(path_id: path.uuid)
    [{v: path.value == '' ? '/' : path.value, f: link}, parent_path_value, '']
  end

  def show
    id = params[:id]
    unless id.nil?
      if id.match(/^[0-9a-f]{8}-[0-9a-f]{4}-[0-9a-f]{4}-[0-9a-f]{4}-[0-9a-f]{12}$/)
        @page = Page.find_all_by_uuid(id).first
      else
        @page = Page.find(id)
      end
    end

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
    id = params[:id]
    unless id.nil?
      if id.match(/^[0-9a-f]{8}-[0-9a-f]{4}-[0-9a-f]{4}-[0-9a-f]{4}-[0-9a-f]{12}$/)
        @page = Page.find_all_by_uuid(id).firsr
      else
        @page = Page.find(id)
      end
    end
  end

  def create
    @page = Page.new(params[:page])
    match = /^(((?<scheme>.*):\/\/)|)(?<domain>([^\/:]+\.[^\/:]+)|)(:(?<port>[0-9]*)|)((?<path>.*?)|)(\/(?<file_name>[^\/]*?)|)(\?(?<parameter>[^#]*?)|)(#(?<ancor>.*?)|)$/.match(params[:url])
    if match
      @page.path_id   = WebPageAnalyser.get_path_id(@page.domain_id, match[:path])
      @page.file_name = match[:file_name].nil? ? "" : match[:file_name]
      @page.parameter = match[:parameter].nil? ? "" : match[:parameter]
    end

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
    id = params[:id]
    unless id.nil?
      if id.match(/^[0-9a-f]{8}-[0-9a-f]{4}-[0-9a-f]{4}-[0-9a-f]{4}-[0-9a-f]{12}$/)
        @page = Page.find_all_by_uuid(id).first
      else
        @page = Page.find(id)
      end
    end
    match = /^(((?<scheme>.*):\/\/)|)(?<domain>([^\/:]+\.[^\/:]+)|)(:(?<port>[0-9]*)|)((?<path>.*?)|)(\/(?<file_name>[^\/]*?)|)(\?(?<parameter>[^#]*?)|)(#(?<ancor>.*?)|)$/.match(params[:url])
    if match
      @page.path_id   = WebPageAnalyser.get_path_id(@page.domain_id, match[:path])
      @page.file_name = match[:file_name].nil? ? "" : match[:file_name]
      @page.parameter = match[:parameter].nil? ? "" : match[:parameter]
    end

    respond_to do |format|
      if @page.update_attributes(params[:page])
        format.html { redirect_to pages_url(domain_id:@page.domain_id, page:get_paging_position(@page)), notice: 'Page was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @page.errors, status: :unprocessable_entity }
      end
    end
  end

  def destroy
    id = params[:id]
    unless id.nil?
      if id.match(/^[0-9a-f]{8}-[0-9a-f]{4}-[0-9a-f]{4}-[0-9a-f]{4}-[0-9a-f]{12}$/)
        @page = Page.find_all_by_uuid(id).first
      else
        @page = Page.find(id)
      end
    end
    position = get_paging_position(@page)
    @page.destroy

    respond_to do |format|
      format.html { redirect_to pages_url(domain_id:@page.domain_id, page:position), notice: 'Page was successfully deleted.' }
      #format.html { redirect_to domain_url(domain_id), notice: 'Page was successfully deleted.' }
      format.json { head :no_content }
    end
  end

  def get_paging_position(page)
     1 #+ Page.where(domain_id: page.domain_id ).order("path").count(conditions: ["path < ?", page.path]) / @page_size
  end
end

