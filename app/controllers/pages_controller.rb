class PagesController < ApplicationController

  layout "admin" #layout admin means go to layouts and use views/layouts/admin.html.erb
 
  before_action :confirm_logged_in
  before_action :find_subject

  def index
    #@pages = Page.where(:subject_id => @subject.id).sorted.   #sorted comes from pages model
    @pages = @subject.pages.sorted   # same code as above but cleaner code
  end

  def show
    @page = find_params
  end

  def new
    @page = Page.new({:subject_id => @subject.id, :name => "Default"})
    @page_count = Page.count + 1
    @subjects = Subject.order('position ASC')   # for pages/_form.html.erb for the subject variable
  end

  def create
    @page = Page.new(page_params)
    if @page.save
      flash[:notice] = "Page Created Successfully"
      redirect_to(:action => 'index', :subject_id => @subject.id)
    else
      @subjects = Subject.order('position ASC')   # for pages/_form.html.erb for the subject variable
      @page_count = Page.count + 1
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
      redirect_to(:action => 'show', :id => @page.id, :subject_id => @subject.id)
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
    redirect_to(:action => 'index', :subject_id => @subject.id,)
  end


  private

  def page_params
    params.require(:page).permit(:subject_id, :name, :permalink, :position, :visible)
  end

  def find_params
    Page.find(params[:id])    # page params id is the number before the ?
  end

  def find_subject
    if params[:subject_id]
      @subject = Subject.find(params[:subject_id])
    end    
  end
end


