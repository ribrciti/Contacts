class SectionsController < ApplicationController

  layout "admin" #layout admin means go to layouts and use views/layouts/admin.html.erb

  before_action :confirm_logged_in       # from application controller
  before_action :find_page               # private method

  def index
    @sections = @page.sections.sorted
  end

  def show
    @section = find_params
  end

  def new
    @section = Section.new({:page_id => @page.id, :name => "default"})
    @pages = @page.subject.pages.sorted
    @section_count = Section.count + 1
  end

  def create
     @section = Section.new(section_params)
     if @section.save
      flash[:notice] = "Section created successfully"
      redirect_to(:action => 'index', :page_id => @page.id)
     else
      @section_count = Section.count + 1
      @pages = Page.order('position ASC')
      render('new')
     end
  end

  def edit
    @section = find_params
    @section_count = Section.count
    @pages = Page.order('position ASC')
  end

  def update 
    @section = find_params
    if @section.update_attributes(section_params)
      flash[:notice] = "Section updated successfully"
      redirect_to(:action => 'show', :id => @section.id, :page_id => @page.id)
    else
      @section_count = Section.count
      @pages = Page.order('position ASC')
      render('edit')
    end  
  end

  def delete
    @section = find_params
  end

  def destroy
    @section = find_params.destroy
    flash[:notice] = "Successfully deleted Section"  
    redirect_to(:action => 'index', :page_id => @page.id)  
  end


  private

  def section_params
    params.require(:section).permit(:page_id, :name, :position, :visible, :content_type, :content)
  end

  def find_params
    Section.find(params[:id])    # page params id is the number before the ?
  end

  def find_page
    if params[:page_id]
      @page = Page.find(params[:page_id])
    end
  end   
end
