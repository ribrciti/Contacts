class PagesController < ApplicationController

  layout "admin" #layout admin means go to layouts and use views/layouts/admin.html.erb
 
  before_action :confirm_logged_in

  def index
    @pages = Page.sorted   #sorted comes from pages model
  end

  def show
    @page = find_params
  end

  def new
    @page = Page.new({:name => "Default"})
    @page_count = Page.count + 1
    @subjects = Subject.order('position ASC')   # for pages/_form.html.erb for the subject variable
  end

  def create
    @page = Page.new(page_params)
    if @page.save
      flash[:notice] = "Page Created Successfully"
      redirect_to(:action => 'index')
    else
      @page_count = Page.count + 1
      @subjects = Subject.order('position ASC')   # for pages/_form.html.erb for the subject variable
      render('new')
    end
  end

  def edit
    @page = find_params    
    @page_count = Page.count   # for pages/_form.html.erb for the position variable
    @subjects = Subject.order('position ASC')   # for pages/_form.html.erb for the subject variable
  end

  def update
    @page = find_params    # first find the page to update
    if @page.update_attributes(page_params)
      flash[:notice] = "Page udated successfully"
      redirect_to(:action => 'show', :id => @page.id)
    else
      @page_count = Page.count   # for pages/_form.html.erb for the position variable
      @subjects = Subject.order('position ASC')   # for pages/_form.html.erb for the subject variable
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


