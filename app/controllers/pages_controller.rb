class PagesController < ApplicationController

  layout "admin" #layout admin means go to layouts and use views/layouts/admin.html.erb
 

  def index
    @pages = Page.sorted   #sorted comes from pages model
  end

  def show
    @page = find_params
  end

  def new
    @page = Page.new({:name => "Default"})
  end

  def create
    @page = Page.new(page_params)
    if @page.save
      flash[:notice] = "Page Created Successfully"
      redirect_to(:action => 'index')
    else
      render('new')
    end
  end

  def edit
    @page = find_params
  end

  def update
    @page = find_params    # first find the page to update
    if @page.update_attributes(page_params)
      flash[:notice] = "Page udated successfully"
      redirect_to(:action => 'show', :id => @page.id)
    else
      render('edit')      
    end
    
  end

  def delete
    @page = find_params
  end

  def destroy
    @page = find_params.destroy
    flash[:notice] = "Page deleted successfully"
    redirect_to(:action => 'index')
  end


  private

  def page_params
    params.require(:page).permit(:subject_id, :name, :permalink, :position, :visible)
  end

  def find_params
    Page.find(params[:id])    # page params id is the number before the ?
  end
end


