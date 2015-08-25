class SectionsController < ApplicationController

  layout "admin" #layout admin means go to layouts and use views/layouts/admin.html.erb

  before_action :confirm_logged_in

  def index
    @sections = Section.sorted
  end

  def show
    @section = find_params
  end

  def new
    @section = Section.new({:name => "default"})
    @section_count = Section.count + 1
    @page = Page.order('position ASC')
  end

  def create
     @section = Section.new(section_params)
     if @section.save
      flash[:notice] = "Section created successfully"
      redirect_to(:action => 'index')
     else
      @section_count = Section.count + 1
      @page = Page.order('position ASC')
      render('new')
     end
  end

  def edit
    @section = find_params
    @section_count = Section.count
    @page = Page.order('position ASC')
  end

  def update
    @section = find_params
    if @section.update_attributes(section_params)
      flash[:notice] = "Section updated successfully"
      redirect_to(:action => 'show', :id => @section.id)
    else
      @section_count = Section.count
      @page = Page.order('position ASC')
      render('edit')
    end  
  end

  def delete
    @section = find_params
  end

  def destroy
    @section = find_params.destroy
    flash[:notice] = "Successfully deleted Section"  
    redirect_to(:action => 'index')  
  end


  private

  def section_params
    params.require(:section).permit(:page_id, :name, :position, :visible, :content_type, :content)
  end

  def find_params
    Section.find(params[:id])    # page params id is the number before the ?
  end

end
